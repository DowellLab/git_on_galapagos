
MIRROR_PATH=<path/to/directory/with/mirror/clones>

cd $MIRROR_PATH

for d in `ls -d1 */`; do
    cd $d
    git fetch -p origin
    git push --mirror
    cd ..
done