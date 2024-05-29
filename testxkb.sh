name1='german-essentials'
nameGroup1="English (US, german-essentials)"
langToExtend="us"

cat > ./test.txt << EOL
partial alphanumeric_keys
xkb_symbols "$name1" {

    include "$langToExtend"
    name[Group1]= "$nameGroup1";

    key <AD01> { [	   q,          Q,    adiaeresis,       Adiaeresis ] };
    key <AC02> { [	   s,          S,        ssharp,          section ] };
    key <AD06> { [	   y,          Y,    udiaeresis,       Udiaeresis ] };
    key <AD10> { [	   p,          P,    odiaeresis,       Odiaeresis ] };
    key <AD03> { [	   e,          E,        EuroSign,           EuroSign ] };

    include "level3(ralt_switch)"
};
EOL

# base.lst
  #$name1 $langToExtend: $nameGroup1
  
# base.xml, evdev.xml
  #<variant>
#          <configItem>
#            <name>$name1</name>
#            <description>$nameGroup1</description>
#          </configItem>
#  </variant>

