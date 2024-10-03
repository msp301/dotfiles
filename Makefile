all:
	stow --verbose --target=$(HOME)/.config --restow config

clean:
	stow --verbose --target=$(HOME)/.config --delete config

