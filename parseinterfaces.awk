# parse data out of /etc/network/interfaces
# ie: awk -v i=eth0 -v p=address -f parseinterfaces.awk /etc/network/interfaces
{
    if ($1 == "iface")  {
        if ($2 == i) {
                m = 1;
                next;
            }
        }
    if (m) {
        if ($1 == p) {
                print $2;
                exit;
        }
    }
    next;
}
