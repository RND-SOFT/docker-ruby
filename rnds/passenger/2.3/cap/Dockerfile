FROM rnds/passenger:2.3
MAINTAINER Firmhouse "kinnalru@gmail.com"

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtsOlzYQ4y+7BOFOH+tCzjCVvZxT4kotXsx8gK0LEd9wZi3PzIb2oOYxsWJd3KY8+2xodBv7wnTch0O1GMOiZW4V8fSo1rq3C5h2WIkeEcbgUbc/JU+JSXhrr87icar23YX9Yo4swbfL4kPTURJu12z9J/FlbVbPm3TIyZr+jiq69aNc/GTo/tcgVHJMUON+QBoxbtpyeqFBf3n1wBl8/ACWKcTJ/hA6gSk+qHktmt7aTbZQ2JkcLZBUfXV5gvflil7ZLa+UzLSqBkrHcgyQFSXaZPICjLT8GcUL3uD8yghzn2FDt0UF4doqONY/Hq1vahvBv6EFrm3yWfqfFdoeuUw== sfedosov\n" >> /root/.ssh/authorized_keys \
 && echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA4AzFeVD2aD7vjlLYM4bnA74WtPS9Jkijav9cw4zTUGVVDdoAD3xMtfWO2InM/P+SdXUQIm+52YPfMypS/aMn6ZK/EdqIR2eyzmMNu3HU18yb5PxoHh42HBkSx5kz2et1OgQxsEvq9VOavHPaRezIdq6bW1P8jn7cPygrioNqLTW7y6rRw6+xBfrnBBGmDwrViYRRJ7Nw57oJgyF1z3ANXpJD+j8nVrpB4jcycENzguoVFxpWtw5AN6yGY8EiktCIUVCajj0O7NaTSRPalk21lM6WNvJlDuUYNo2Ca9xXcD1L/f9QzOdOnxqXokzoi6uU9XEWUYKBVmZ59TjqWXVEzw== oshlykov\n" >> /root/.ssh/authorized_keys \
 && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/0wT+wpwfn/M17yJI/+awdhk7suF0WCtZTaI5CtJyfsxFMN9l8z2QXIs1VDecqzrUTekjxI9SJ0Zz54eXLZF6KfaSQ3qPOJQqNjz3p8ZUugcXClRAwU4ypCYmMn0SaSbpUqz1k3R3Mgtw61J+9ArZPE6MrnStCjgs18xqX5XSnldEkFhYr1GyZgaGxHlhHn58SyAtUGb51cXQB/7yrdqChIQGoQvX0AclVxzwjKa6K2t7vr3T3adCX/rkT2gzGAwBI+8IA6SQYfYubBzBaqtLOVwBsW0qiWzmD9jiGZ9d5qQzAeZsSD/1glkLLT8cLmow1BitWhU9PIYH9EWIfaht kinnalru@gmail.com\n" >> /root/.ssh/authorized_keys \
 && rm -f /etc/service/sshd/down \
 && rm -f /etc/service/nginx/down \
 && /etc/my_init.d/00_regen_ssh_host_keys.sh \
 && rm /etc/nginx/sites-enabled/default

RUN bash -lc 'rvm --default use ruby-2.3.3'

WORKDIR /home/app

CMD ["/sbin/my_init"]
