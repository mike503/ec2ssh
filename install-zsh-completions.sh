

mkdir -p ~/.zsh-completions
cp ec2ssh.zsh_completion.zsh ~/.zsh-completions/_ec2ssh
chmod +x ~/.zsh-completions/_ec2ssh
echo >> ~/.zshrc
echo "~/.zsh-completions/_ec2ssh" >> ~/.zshrc
echo >> ~/.zshrc
