#![no_main]
#![no_std]
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
        loop {}
}

extern "C" {
        fn uart_puts(input: *const u8);
        fn printf(fmt: *const u8, ...);
}
#[no_mangle]
pub extern "C" fn rust_test() {

        const MSG: &'static str = "Hello Rust!\n\0";
        const PRINTF_MSG: &'static str = "Hello Rust printf %d!\n\0";
        const PRINTF_INT: i32 = 1234;
        unsafe {
                uart_puts(MSG.as_ptr());
                printf(PRINTF_MSG.as_ptr(), PRINTF_INT);
        }
}
