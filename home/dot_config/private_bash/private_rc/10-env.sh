# User specific environment
personal_bin_root=${PERSONAL_ENV_HOME:-$HOME}
case :$PATH: in
  *:"$personal_bin_root/.local/bin":*) ;;
  *) PATH="$personal_bin_root/.local/bin:$PATH" ;;
esac
case :$PATH: in
  *:"$personal_bin_root/bin":*) ;;
  *) PATH="$personal_bin_root/bin:$PATH" ;;
esac
export PATH
unset personal_bin_root
