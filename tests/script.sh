# Check syntax in php files.
find . -type "f" -iname "*.php" | xargs -L "1" php -l

# Run tests.
cd tests && phpunit --configuration phpunit.xml

# Prohibit tab characters in php files.
tab_char=$(find . -type "f" -iname "*.php" -exec grep --line-number -H --perl-regexp "\t" {} \;)
if [[ ! -z "${tab_char}" ]]; then
    echo -e "${tab_char}" | perl -pe 's/^(.*)$/Tab character found in \1/'
    exit 1
fi

# Prohibit trailing whitespace in php files.
trailing_whitespace=$(find . -type "f" -iname "*.php" -exec egrep --line-number -H " +$" {} \;)
if [[ ! -z "${trailing_whitespace}" ]]; then
    echo -e "${trailing_whitespace}" | perl -pe 's/^(.*)$/Trailing whitespace found in \1/'
    exit 1
fi
