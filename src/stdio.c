int printf(const char *format, ...) {
        int ret;
        __builtin_va_list argv;
        __builtin_va_start(argv, format);
        // TODO parse format
        __builtin_va_end(argv);
        return ret;

}
