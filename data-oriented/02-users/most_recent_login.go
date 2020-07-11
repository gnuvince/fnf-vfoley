package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

func pressEnterToContinue() {
	// reader := bufio.NewReader(os.Stdin)
	// fmt.Println("Press <Enter> to continue...")
	// reader.ReadString('\n')
}

func loadCsv(filename string) ([][]string, error) {
	file, err := os.Open("users.csv")
	if err != nil {
		fmt.Fprintf(os.Stderr, "users.csv is not there\n")
		return nil, err
	}
	reader := bufio.NewReader(file)

	var rows [][]string
	for {
		line, err := reader.ReadString('\n')
		if err != nil {
			break
		}
		fields := strings.Split(strings.TrimSpace(line), ":")
		rows = append(rows, fields)
	}
	return rows, nil
}

func aos(filename string) {
	type User = struct {
		id         int64
		username   string
		homedir    string
		shell      string
		last_login int64
	}

	rows, err := loadCsv(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "cannot open %s: %s\n", filename, err)
		return
	}

	var users []User
	for _, fields := range rows {
		id, err := strconv.Atoi(fields[0])
		if err != nil {
			fmt.Fprintf(os.Stderr, "error converting id: %+v\n", err)
			continue
		}
		last_login, err := strconv.Atoi(fields[4])
		if err != nil {
			fmt.Fprintf(os.Stderr, "error converting last_login: %+v\n", err)
			continue
		}

		user := User{
			id:         int64(id),
			username:   fields[1],
			homedir:    fields[2],
			shell:      fields[3],
			last_login: int64(last_login),
		}
		users = append(users, user)
	}

	pressEnterToContinue()

	start := time.Now()
	latest_timestamp := int64(0)
	latest_username := ""
	for _, user := range users {
		if user.last_login > latest_timestamp {
			latest_timestamp = user.last_login
			latest_username = user.username
		}
	}
	end := time.Now()
	fmt.Printf("last_login: %d; user: %s, time: %+v\n",
		latest_timestamp, latest_username, end.Sub(start))
}

func hotCold(filename string) {
	type UserInfo = struct {
		id       int64
		username string
		homedir  string
		shell    string
	}
	type User = struct {
		info       *UserInfo
		last_login int64
	}

	rows, err := loadCsv(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "cannot open %s: %s\n", filename, err)
		return
	}

	var users []User
	for _, fields := range rows {
		id, err := strconv.Atoi(fields[0])
		if err != nil {
			fmt.Fprintf(os.Stderr, "error converting id: %+v\n", err)
			continue
		}
		last_login, err := strconv.Atoi(fields[4])
		if err != nil {
			fmt.Fprintf(os.Stderr, "error converting last_login: %+v\n", err)
			continue
		}

		var user User
		var info UserInfo
		info.id = int64(id)
		info.username = fields[1]
		info.homedir = fields[2]
		info.shell = fields[3]
		user.info = &info
		user.last_login = int64(last_login)

		users = append(users, user)
	}

	pressEnterToContinue()

	start := time.Now()
	latest_timestamp := int64(0)
	latest_username := ""
	for _, user := range users {
		if user.last_login > latest_timestamp {
			latest_timestamp = user.last_login
			latest_username = user.info.username
		}
	}
	end := time.Now()
	fmt.Printf("last_login: %d; user: %s; time: %+v\n",
		latest_timestamp, latest_username, end.Sub(start))
}

func soa(filename string) {
	type Users = struct {
		id         []int64
		username   []string
		homedir    []string
		shell      []string
		last_login []int64
	}

	rows, err := loadCsv(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "cannot open %s: %s\n", filename, err)
		return
	}

	var users Users
	for _, fields := range rows {
		id, err := strconv.Atoi(fields[0])
		if err != nil {
			fmt.Fprintf(os.Stderr, "error converting id: %+v\n", err)
			continue
		}
		last_login, err := strconv.Atoi(fields[4])
		if err != nil {
			fmt.Fprintf(os.Stderr, "error converting last_login: %+v\n", err)
			continue
		}

		users.id = append(users.id, int64(id))
		users.username = append(users.username, fields[1])
		users.homedir = append(users.homedir, fields[2])
		users.shell = append(users.shell, fields[3])
		users.last_login = append(users.last_login, int64(last_login))
	}

	pressEnterToContinue()

	start := time.Now()
	latest_timestamp := int64(0)
	latest_entity := 0
	for i, last_login := range users.last_login {
		if last_login > latest_timestamp {
			latest_timestamp = last_login
			latest_entity = i
		}
	}
	end := time.Now()
	fmt.Printf("last_login: %d; user: %s; time: %+v\n",
		latest_timestamp, users.username[latest_entity], end.Sub(start))

}

func main() {
	var flagAos = flag.Bool("aos", false, "do AOS run")
	var flagHotCold = flag.Bool("hotcold", false, "do hot/cold run")
	var flagSoa = flag.Bool("soa", false, "do SOA run")
	var filename = flag.String("filename", "users.csv", "name of the file")
	flag.Parse()

	if (*flagAos) {
		aos(*filename)
	}
	if (*flagHotCold) {
		hotCold(*filename)
	}
	if (*flagSoa) {
		soa(*filename)
	}
}
