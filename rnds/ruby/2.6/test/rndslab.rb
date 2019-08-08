#!/usr/bin/env ruby

require 'optparse'
require 'gitlab'
require 'nokogiri'
require 'json'
require 'restclient'

UTIL = File.basename(__FILE__)

@opts = {
  gitlab: ENV['GITLAB'] || 'https://gitlab.com',
  token: ENV['GITLAB_API_PRIVATE_TOKEN']
}

parser = OptionParser.new do |o|
  o.banner = "Usage: #{UTIL} [options]"

  o.on('-g', "--gitlab gitlab=#{@opts[:gitlab]}", 'Gitlab host or GITLAB env') do |gitlab|
    @opts[:gitlab] = gitlab.strip
  end

  o.on('-t', '--token TOKEN', 'Gitlab API token or GITLAB_API_PRIVATE_TOKEN env') do |token|
    @opts[:token] = token.strip
  end

  o.on('-j', '--project PROJECT', 'Gitlab project number') do |project|
    @opts[:project] = project.strip
  end

  o.on('--mr-branch MR', 'Gitlab merge request source branch') do |mrbranch|
    @opts[:mrbranch] = mrbranch.strip
  end

  o.on('-u', '--user USER', 'Gitlab username') do |user|
    @opts[:user] = user.strip
  end

  o.on('-p', '--password PASS', 'Gitlab password') do |pass|
    @opts[:pass] = pass.strip
  end

  o.on('--drop-comments', 'Remove all comments in current MR') do
    @opts[:drop] = true
  end
  
  o.on('--badge <badge>', 'Generate badge "script||text||color||link||id"') do |badge|
    @opts[:badges] ||= []
    @opts[:badges] << badge
  end
end

parser.parse!

raise 'gitlab not defined' if @opts[:gitlab].to_s.empty?
raise 'token not defined' if @opts[:token].to_s.empty?

Gitlab.endpoint = "#{@opts[:gitlab]}/api/v4"
Gitlab.private_token = @opts[:token]

$cookies = {}

def with_cookies &block
  response = yield($cookies)
  $cookies = response.cookies
  response
rescue RestClient::ExceptionWithResponse => e
  response = e.response
  $cookies = response.cookies
  response
end

$g = g = Gitlab.client
@current_user = g.user

def authorize url, login, password
  response = with_cookies do
    RestClient.get(url)
  end

  xml = Nokogiri::XML(response.body)
  $auth_token = xml.search('meta[name="csrf-token"]').attribute('content').value

  payload = {
    authenticity_token: $auth_token,
    user: {login: login, password: password, remember_me: 0}
  }

  response = with_cookies do |cookies|
    RestClient.post(url, payload, {cookies: cookies})
  end

  response = with_cookies do |cookies|
    RestClient.get(response.headers[:location], {cookies: cookies})
  end

  xml = Nokogiri::XML(response.body)
  $auth_token = xml.search('meta[name="csrf-token"]').attribute('content').value

  response
end

if @opts[:drop]
  raise 'user not defined' if @opts[:user].to_s.empty?
  raise 'password not defined' if @opts[:pass].to_s.empty?
  raise 'project not defined' if @opts[:project].to_s.empty?
  raise 'MR not defined' if @opts[:mrbranch].to_s.empty?

  puts "Current user: #{@current_user.name} #{@current_user.username} #{@current_user.id}"
  authorize("#{@opts[:gitlab]}/users/sign_in", @opts[:user], @opts[:pass])

  project_path = g.project(@opts[:project]).path_with_namespace
  if mr = g.merge_requests(@opts[:project], source_branch: @opts[:mrbranch]).first
    mr_iid = mr.iid
  else
    puts "Could't found MR '#{@opts[:mrbranch]}' in #{@opts[:project]} project"
    exit 0
  end

  response = with_cookies do |cookies|
    RestClient.get("#{@opts[:gitlab]}/#{project_path}/merge_requests/#{mr_iid}/discussions.json", cookies: cookies)
  end

  notes = JSON(response.body).map {|d| d['notes']}.flatten
  owned = notes.select{|n| n.dig('author', 'id') == @current_user.id}
  ids = owned.map {|n| n['id']}

  puts "Deleting comments: #{ids.inspect}"
  ids.each do |id|
    with_cookies do |cookies|
      RestClient.delete("#{@opts[:gitlab]}/#{project_path}/notes/#{id}", 'x-csrf-token' => $auth_token, cookies: cookies)
    end
  end

  exit 0
end

def update_badge project, badge
  script, text, color, link, id = badge.split('||')
  
  value = `#{script}`.strip.split("\n").first.strip
  image_url="https://badgen.net/badge/#{text.gsub(' ', '%20')}/#{value.gsub(' ', '%20')}/#{color}"
  $g.edit_project_badge(project, id, link_url: link, image_url: image_url)
end

if @opts[:badges].any?
  raise 'project not defined' if @opts[:project].to_s.empty?
  
  @opts[:badges].each do |badge|
    update_badge @opts[:project], badge
  end
  exit 0
end

STDERR.puts parser.help
exit 1
