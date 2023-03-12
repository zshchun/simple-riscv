#![no_main]
#![no_std]
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
        loop {}
}

extern "C" {
        fn uart_puts(input: *const u8);
}
#[no_mangle]
pub extern "C" fn rust_test() {

        const MSG: &'static str = "Hello Rust!\n\0";
        unsafe {
                uart_puts(MSG.as_ptr());
        }
}
