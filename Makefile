install:
	echo "I'll get to it later! 😅"

sync:
	mkdir -p configs
	cp $(HOME)/.aliases ./configs/
	cp $(HOME)/.profile ./configs/
	cp $(HOME)/.vimrc ./configs/
	cp $(HOME)/.zshrc ./configs/

	# oh-my-zsh themes
	cp -r $(ZSH)/custom/themes ./

