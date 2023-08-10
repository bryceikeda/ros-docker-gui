ARG ARG_FROM

FROM $ARG_FROM
MAINTAINER Athanasios Tasoglou <athanasios@tasoglou.net>

RUN sh -c \
	"$(curl -fsSL https://raw.githubusercontent.com/bryceikeda/dotfiles/main/tools/install.sh)" "" \
	--full --skip-decrypt

# Launch terminator
CMD ["terminator"]
