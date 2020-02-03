#!/usr/bin/env bash

sudo apt install -y zsh git curl

rm -rf ~/.oh-my-zsh ~/.zshrc ~/.zplug

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/custom/themes/spaceship-prompt

ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

sed -i 's/^ZSH_THEME=.*/ZSH_THEME="spaceship"/g' ~/.zshrc

echo '
SPACESHIP_PROMPT_ORDER=( 
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
#SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SYMBOLSPACESHIP_CHAR_SYMBOL=" "
SPACESHIP_CHAR_SUFFIX=" " ' >> ~/.zshrc

echo ' ' >> ~/.zshrc
echo 'zplugin light zsh-users/zsh-autosuggestions' >> ~/.zshrc
echo 'zplugin light zsh-users/zsh-completions' >> ~/.zshrc
echo 'zplugin light zdharma/fast-syntax-highlighting' >> ~/.zshrc

chsh -s /bin/zsh

zsh
