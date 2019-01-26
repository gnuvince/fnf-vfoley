#!/bin/bash

# We've implemented a change in the `master` branch, but we really
# should have made them in a separate `my-feature` branch.  Can we fix
# this situation?
#
# Solution:
# 1. Add a new branch, `my-feature`, that points to the
#    last commit (Document my feature).
#
#   git branch my-feature
#
#    The current branch hasn't changed it's still `master`.
#
# 2. Move the `master` branch back to the initial commit
#
#   git reset <initial commit hash>
demo1() {
    git init demo-01
    (
        cd demo-01
        git commit --allow-empty -m "initial commit"
        git commit --allow-empty -m "Implement my feature"
        git commit --allow-empty -m "Test my feature"
        git commit --allow-empty -m "Document my feature"
    )
}

# We've implemented our changes in a separate branch, but we've been a
# bit messy in our commits and in their messages.  Can we make the
# history nicer before we merge?
#
# Solution:
# 1. Squash the first two commits together
#
#   git rebase -i <commit BEFORE "implement my feature">
#
# 2. Fixup the documentation commits together
#
#   git rebase -i <commit BEFORE "implement my feature">
demo2() {
    git init demo-02
    (
        cd demo-02
        git commit --allow-empty -m "initial commit"
        git checkout -b my-feature

        echo hack >> main.c
        git add main.c
        git commit -m "Implement my feature"

        echo hackhack >> main.c
        git add main.c
        git commit -m "More implementation of the feature"

        echo a > README.md
        git add README.md
        git commit -m "Add documentation"

        echo b > README.md
        git add README.md
        git commit -m "fix typo"

        echo c > README.md
        git add README.md
        git commit -m "fix typo"

        echo d > README.md
        git add README.md
        git commit -m "fix typo"

        echo e > README.md
        git add README.md
        git commit -m 'fix typo (ARGH!!!!)'
    )
}


# We've made a commit in a branch, but it really should be in its own
# branch.  How can we move a commit from one branch to another?
#
# 1. Create a new branch for the bug fix
#
#   git checkout -b bugfix master
#
# 2. Cherry-pick the bugfix commit
#
#   git cherry-pick <bugfix commit>
#
# 3. Go back to `my-feature` and remove the bugfix commit
#
#   git checkout my-feature
#   git rebase -i <commit before Implement my feature>
demo3() {
    git init demo-03
    (
        cd demo-03
        git commit --allow-empty -m "initial commit"
        git checkout -b my-feature

        echo hack > main.c
        git add main.c
        git commit -m "Implement my feature"

        echo test > test.c
        git add test.c
        git commit -m "Test my feature"

        echo FIX > bugfix.txt
        git add bugfix.txt
        git commit -m "Fix bug #1234"

        echo doc > README.md
        git add README.md
        git commit -m "Document my feature"
    )
}


# We've made a big commit, but now we'd like to split it into
# multiple, smaller commits.
#
# Solution:
#
#   git reset master~1
#   git add main.c test.c
#   git commit -m "Implement my feature"
#   git add bugfix.txt
#   git commit -m "Fix bug #1234"
#
# Note: Using `git reset` only works because this is the last commit.
#       If it was an earlier commit, we'd have to use `git rebase -i`,
#       select the `edit` action on the commit we want to split, do
#       the actions listed above, and finish with `git rebase --continue`.
demo4() {
    git init demo-04
    (
        cd demo-04
        echo a > main.c
        echo b > test.c
        echo c > bugfix.txt

        git commit --allow-empty -m "initial commit"
        git add main.c test.c bugfix.txt
        git commit -m "Implement my feature and fix bug #1234"
    )
}


# We've used `git reset` and lost a very important commit!
# Is it lost forever?
demo5() {
    git init demo-05
    (
        cd demo-05
        git commit --allow-empty -m "initial commit"
        git commit --allow-empty -m "super important commit, DO NOT LOSE"
        git reset HEAD~1
    )
}


# We've made some changes, we've pushed them, and now we want to undo
# them.  Should we use `git rebase -i`?  (NO!!)
#
# Solution:
#
#   git revert <commit with defects>
demo6() {
    git init demo-06
    (
        cd demo-06
        git commit --allow-empty -m "initial commit"

        echo 42 > best-number.txt
        git add best-number.txt
        git commit -m "good commit"

        echo 5 > best-number.txt
        git add best-number.txt
        git commit -m "commit with defects"

        echo 4 > two-plus-two.txt
        git add two-plus-two.txt
        git commit -m "another good commit"
        git branch origin/master
    )
}


demo1
demo2
demo3
demo4
demo5
demo6
