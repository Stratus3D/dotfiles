# Remove old rbenv
rm -rf ~/.rbenv

# Clone from GitHub
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

# Add to path
#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile # this should already be done

# Add init command to shell
#echo 'eval "$(rbenv init -)"' >> ~/.bash_profile # this should already be done

# rbenv should be a function
type rbenv

# Install ruby-build so we can easily install ruby versions
# Create a temp folder for installation
TEMP=$(mktemp);

# Clone down ruby-build into temp folder
git clone https://github.com/sstephenson/ruby-build.git $TEMP

# Go to temp folder and run install script
cd $TEMP
./install.sh
