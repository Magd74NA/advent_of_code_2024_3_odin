package mull_it_over

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:text/regex"

mul_regex :: `mul\((\d{1,3}),(\d{1,3})\)`

main :: proc () {
	//trying out the or_else operator
    data := os.read_entire_file("input.txt") or_else os.exit(1)
    defer delete(data)

    reg := regex.create(mul_regex, flags = {.Global}) or_else os.exit(1)

	str := string(data)

	total:=0
	doBlock := strings.split(str, `do()`)
	for &dos in doBlock {
		end:=strings.index(dos, `don't()`)
		subtotal := 0
		index := 0
		if end == -1 {
			end = len(dos)
		}
		for groups in regex.match(reg, dos[index:end]) {
			subtotal += strconv.atoi(groups.groups[1]) * strconv.atoi(groups.groups[2])
			index += groups.pos[0][1]
		}
		total+=subtotal
	}



	fmt.printf("total:%d", total)
}