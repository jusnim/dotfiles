#https://codeaffen.org/2023/09/16/custom-keyboard-layouts-with-xkb/
name='us-german-essentials'
nameshort="usde-es"
nameGroup="English (US, german-essentials)"
langToExtend="us"

mkdir $HOME/.config/xkb
mkdir $HOME/.config/xkb/symbols

cat > $HOME/.config/xkb/symbols/$name << EOL
partial alphanumeric_keys
xkb_symbols "$nameshort" {

    include "$langToExtend"
    name[Group1]= "$nameGroup";

    key <AD01> { [	   q,          Q,    adiaeresis,       Adiaeresis ] };
    key <AC02> { [	   s,          S,        ssharp,          section ] };
    key <AD06> { [	   y,          Y,    udiaeresis,       Udiaeresis ] };
    key <AD10> { [	   p,          P,    odiaeresis,       Odiaeresis ] };
    key <AD03> { [	   e,          E,        EuroSign,           EuroSign ] };

    include "level3(ralt_switch)"
};
EOL

mkdir $HOME/.config/xkb/rules
cat > $HOME/.config/xkb/rules/evdev << EOL
! option   = symbols
  $name:$nameshort  = +$name($nameshort)

! include %S/evdev
EOL

cat > $HOME/.config/xkb/rules/evdev.xml << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xkbConfigRegistry SYSTEM "xkb.dtd">
<xkbConfigRegistry version="1.1">
  <layoutList>
    <layout>
      <configItem>
        <name>$name</name>
        <shortDescription>$shortname</shortDescription>
        <description>$nameGroup</description>
        <countryList>
          <iso3166Id>US</iso3166Id>
          <iso3166Id>DE</iso3166Id>
        </countryList>
        <languageList>
          <iso639Id>eng</iso639Id>
          <iso639Id>deu</iso639Id>
        </languageList>
      </configItem>
    </layout>
  </layoutList>
</xkbConfigRegistry>
EOL

sudo ln -s $HOME/.config/xkb/symbols/$name /usr/share/X11/xkb/symbols
