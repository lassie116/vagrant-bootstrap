require 'unix_crypt'

package 'git'
package 'emacs24-nox'
package 'lv'
package 'tmux'
package 'zsh'

USERNAME = 'lassie'
HOME = "/home/#{USERNAME}"
user USERNAME do
  action :create
  shell '/bin/zsh'
  create_home true
  password UnixCrypt::SHA512.build(USERNAME,"")
end

git  "#{HOME}/dotfiles" do
  user USERNAME
  #  revision "arch_linux_work"
  revision "5818a0e"
  repository "https://github.com/lassie116/dotfiles.git"
end

git "#{HOME}/.emacs.d" do
  user USERNAME
  revision "80243cd"
  repository "https://github.com/lassie116/emacs.d.git"
end

link "#{HOME}/.zshrc" do
  user USERNAME
  to "#{HOME}/dotfiles/zshrc"
end

link "#{HOME}/.zshenv" do
  user USERNAME
  to "#{HOME}/dotfiles/zshenv"
end

link "#{HOME}/.tmux.conf" do
  user USERNAME
  to "#{HOME}/dotfiles/tmux.conf"
end

link "#{HOME}/.gitconfig" do
  user USERNAME
  to "#{HOME}/dotfiles/gitcocnfig"
end

file "/etc/sudoers" do
  action :edit
  block do |content|
    content << "#{USERNAME}        ALL=(ALL)       NOPASSWD: ALL\n"
  end
  not_if "sudo grep #{USERNAME} /etc/sudoers"
end

