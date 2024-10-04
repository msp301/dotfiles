all:
	stow --verbose --target=$(HOME)/.config            --restow config
	stow --verbose --target=$(HOME)/.local             --restow local
	stow --verbose --target=$(HOME)         --dotfiles --restow home

clean:
	stow --verbose --target=$(HOME)/.config            --delete config
	stow --verbose --target=$(HOME)/.local             --delete local
	stow --verbose --target=$(HOME)         --dotfiles --delete home

