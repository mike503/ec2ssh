_ec2ssh()
{

  local cur_word instance_list

  COMPREPLY=()

  # COMP_WORDS is an array of words in the current command line.
  # COMP_CWORD is the index of the current word (the one the cursor is in.)
  # COMP_WORDS[COMP_CWORD] is the current word.
  cur_word="${COMP_WORDS[COMP_CWORD]}"

  instance_list=`aws ec2 describe-instances --filter "Name=instance-state-name,Values=running" --output text | grep "^TAGS[[:space:]]Name" | cut -f 3- | awk -F"|||" '{ printf $1 "\n" }'`

  # instead of using spaces for word separators, use newlines which we've included.
  # this appears to be the only safe way it actually works.
  local IFS=$'\n'
  COMPREPLY=( $(compgen -W "${instance_list}" -- "${cur_word}") )

  return 0
}

# -o filenames seems to be incredibly important here
complete -o filenames -F _ec2ssh ec2ssh
