ARG ARG_FROM

FROM $ARG_FROM
MAINTAINER Athanasios Tasoglou <athanasios@tasoglou.net>

RUN apt-get update && apt-get install -y \
code && \
apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install cpplint

# Launch terminator
CMD ["terminator"]
