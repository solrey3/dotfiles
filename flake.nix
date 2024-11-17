{
  description = "Dotfiles for solrey3";

  outputs = { self, ... }: {
    # Expose the dotfiles repository's content
    packages."dotfiles" = self;
  };
}
