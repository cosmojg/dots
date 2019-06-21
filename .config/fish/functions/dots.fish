function dots --description 'Manage dotfiles with Git'
	command git --git-dir=$HOME/.dots/ --work-tree=$HOME $argv
end
