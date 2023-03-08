void spin_lock(int *lock) {
        int old = 0;
        while (!__atomic_compare_exchange_n(lock, &old, 1, 0, \
                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)) {
                old = 0;
                }
}
void spin_unlock(int *lock) {
        __atomic_store_n(lock, 0, __ATOMIC_SEQ_CST);
}
