void spin_lock(int *lock) {
        while (!__atomic_compare_exchange_n(lock, 0, 1, 0, \
                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)) { ; }
}
void spin_unlock(int *lock) {
        __atomic_store_n(lock, 0, __ATOMIC_SEQ_CST);
}
