int printf(const char *format, ...) {
        __builtin_va_list argv;
        __builtin_va_start(argv, fmt);
        // TODO parse format
        __builtin_va_end(argv);
        return ret;

}
