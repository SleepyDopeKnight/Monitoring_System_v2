function check_input {

    export symbol_count=${#p1}
    if [[ $symbol_count -gt 7 ]]; then
        echo "$p1: Long directory name (7 symbols max)"
        exit 1
    fi

    if [[ $p1 =~ [^A-Za-z] ]]; then
        echo "$p3: U can use only english letters"
        exit 1
    fi

    if [[ ! $p2 =~ ^([A-Za-z]{1,7}).([A-Za-z]{1,3})$ ]]; then
        echo "Long file name (7 symbols max)/Long file extension (3 symbols max)"
        exit 1
    fi

    if [[ ! $p3 =~ ^([0-9]+Mb) ]]; then
        echo "$p3: Wrong size of file"
        exit 1
    fi

    file_size=$p3
    only_size=${file_size%Mb}
    if [[ ! $only_size > 0 || ! $only_size -le 100 ]]; then
        echo "$p3: File size more than 100Mb"
        exit 1
    fi
}