for f in $(rg 'curl=\(' /nix/store/*-builder.sh -l)
do  sudo sed -i.bak  '15i -x 127.0.0.1:7897' $f
done

