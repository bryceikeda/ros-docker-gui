ARG ARG_FROM

FROM $ARG_FROM
MAINTAINER Athanasios Tasoglou <athanasios@tasoglou.net>

RUN sudo sh -c \
	"$(curl -fsSL https://raw.githubusercontent.com/bryceikeda/dotfiles/main/tools/install.sh)" "" \
	--full --skip-decrypt

# Install VS Code
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

RUN apt-get update && apt-get install -y \
code && \
apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install cpplint

# Launch terminator
CMD ["terminator"]
