# Tmux Username and Root

Enables displaying username (whoami) and root status information in Tmux `status-right` 
and `status-left`.

## Installation
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'Avyiel/tmux-uroot'

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-right`, they should now be visible.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-uroot ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/uroot.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

If format strings are added to `status-right`, they should now be visible.

## Usage

Add any of the supported format strings (see below) to the existing `status-right` tmux option.
Example:

    # in .tmux.conf
    set -g status-right '#{username}#{root} | %a %h-%d %H:%M '


### Maintainer

 - [Lucas Vienna](https://github.com/ctjhoa)

### License

[MIT](LICENSE.md)
