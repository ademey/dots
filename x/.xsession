# https://www.reddit.com/r/openbsd/comments/klwued/trouble_with_env_variables_and_profile/
# Simulate "login shell"
. ~/.profile
. ~/.kshrc

exec i3
