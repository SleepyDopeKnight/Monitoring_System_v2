function check_input {
    end=$(echo $p1 | head -c 1)
    if [[ $end != "/" ]]; then
        echo "$p1: Wrong directory"
        exit 1
    fi

    if [[ $p2 =~ [^0-9] ]]; then
        echo "$p2: Wrong number of folders"
        exit 1
    fi

    export symbol_count=${#p3}
    if [[ $symbol_count -gt 7 ]]; then
        echo "$p3: Long directory name (7 symbols max)"
        exit 1
    fi

    if [[ $p3 =~ [^A-Za-z] ]]; then
        echo "$p3: U can use only english letters"
        exit 1
    fi

    if [[ $p4 =~ [^0-9] ]]; then
        echo "$p4: Wrong number of files in folders"
        exit 1
    fi

    if [[ ! $p5 =~ ^([A-Za-z]{1,7}).([A-Za-z]{1,3})$ ]]; then
        echo "Long file name (7 symbols max)/Long file extension (3 symbols max)"
        exit 1
    fi

    if [[ ! $p6 =~ ^([0-9]+kb) ]]; then
        echo "$p6: Wrong size of file"
        exit 1
    fi

    file_size=$p6
    only_size=${file_size%kb}
    if [[ ! $only_size > 0 || ! $only_size -le 100 ]]; then
        echo "$p6: File size more than 100Kb"
        exit 1
    fi
}