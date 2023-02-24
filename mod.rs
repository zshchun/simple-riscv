#![no_main]
use std::ffi::CString;
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn rust_test() {
        extern "C" {
                fn uart_puts(input: *const c_char);
        }
        unsafe {
//                uart_puts("Hello rust!\n".as_ptr());
                let msg = CString::new("Hello rust!\n").unwrap();
                uart_puts((&msg).as_ptr());
        }
}
