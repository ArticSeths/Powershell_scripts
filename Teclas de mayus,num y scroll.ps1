$code=@' 
using System; 
using System.Runtime.InteropServices; 
 
public static class Keyboard{ 
     
    [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true, CallingConvention = CallingConvention.Winapi)] 
    public static extern short GetKeyState(int keyCode); 
     
    public static bool Numlock{ 
        get{ 
            return (((ushort)GetKeyState(0x90)) & 0xffff) != 0; 
        } 
    } 
     
     public static bool CapsLock{ 
         get{ 
            return (((ushort)GetKeyState(0x14)) & 0xffff) != 0; 
        } 
     } 
      
    public static bool ScrollLock{ 
        get{ 
            return (((ushort)GetKeyState(0x91)) & 0xffff) != 0; 
        } 
    } 
} 
 
'@ 
Add-Type $code 
[Keyboard]::Numlock 
[Keyboard]::CapsLock 
[Keyboard]::ScrollLock 