package chroma;

abstract Color(Int){
    function new(value){
        this = value;
    }
    public static function fromRGB(r : Int, g : Int, b : Int){
        return new Color(r | (g << 8) | (b << 16));
    }

    public function getInt() : Int{
        return this;
    }
}

class Keyboard{
    public static inline var maxRowCount = 6;
    public static inline var maxColCount = 22;
}

abstract KeyboardCustomEffect(hl.Bytes){
    public function new(){
        this = new hl.Bytes(Keyboard.maxRowCount * Keyboard.maxColCount * 4);
    }

    public function ClearWithColor(color : Color){
        for( i in 0 ... Keyboard.maxColCount * Keyboard.maxRowCount){
            this.setI32(i * 4, color.getInt());
        }
    }

    public function SetColor(row : Int, column : Int, color : Color){
        var index = row * Keyboard.maxColCount + column;
        if(index < Keyboard.maxColCount * Keyboard.maxRowCount){
            this.setI32(index * 4, color.getInt());
        }
    }
}

abstract KeyboardCustomKeyEffect(hl.Bytes){
    public function new(){
        this = new hl.Bytes(Keyboard.maxRowCount * Keyboard.maxColCount * 4 * 2);
    }

    public function ClearWithColor(color : Color){
        //Set Base Color
        for( i in 0 ... Keyboard.maxColCount * Keyboard.maxRowCount){
            this.setI32(i * 4, color.getInt());
        }

        //Set Perma Color (remove all override)
        for( i in Keyboard.maxColCount * Keyboard.maxRowCount ... Keyboard.maxColCount * Keyboard.maxRowCount * 2){
            if( i % 2 != 0){
                this.setI32(i * 4, 0);
            }   
        }
    }

    public function SetBaseColor(row : Int, column : Int, color : Color)
    {
        var index = row * Keyboard.maxColCount + column;
        if(index < Keyboard.maxColCount * Keyboard.maxRowCount){
            this.setI32(index * 4, 0x01000000 | color.getInt());
        }
    }

    public function SetPermaColor(row : Int, column : Int, color : Color){
        var index = row * Keyboard.maxColCount + column + Keyboard.maxColCount * Keyboard.maxRowCount;
        if(index < Keyboard.maxColCount * Keyboard.maxRowCount){
            this.setI32(index * 4, 0x01000000 | color.getInt());
        }
    }
}

class Keypad{
    public static inline var maxRowCount = 4;
    public static inline var maxColCount = 5;
}

abstract KeypadCustomEffect(hl.Bytes){
    public function new(){
        this = new hl.Bytes(Keypad.maxRowCount * Keypad.maxColCount * 4);
    }

    public function ClearWithColor(color : Color){
        for( i in 0 ... Keypad.maxColCount * Keypad.maxRowCount){
            this.setI32(i * 4, color.getInt());
        }
    }

    public function SetColor(row : Int, column : Int, color : Color){
        var index = row * Keypad.maxColCount + column;
        if(index < Keypad.maxColCount * Keypad.maxRowCount){
            this.setI32(index * 4, color.getInt());
        }
    }
}

class Mouse{
    public static inline var maxRowCount = 9;
    public static inline var maxColCount = 7;

}

abstract MouseCustomEffect(hl.Bytes)
{
    public function new(){
        this = new hl.Bytes(Mouse.maxRowCount * Mouse.maxColCount * 4);
    }

    public function ClearWithColor(color : Color){
        for( i in 0 ... Mouse.maxColCount * Mouse.maxRowCount){
            this.setI32(i * 4, color.getInt());
        }
    }

    public function SetColor(row : Int, column : Int, color : Color){
        var index = row * Keyboard.maxColCount + column;
        if(index < Mouse.maxColCount * Mouse.maxRowCount){
            this.setI32(index * 4, color.getInt());
        }
    }
}

class Headset{
    public static inline var maxLedsCount = 5;
}

abstract HeadsetCustomEffect(hl.Bytes)
{
    public function new(){
        this = new hl.Bytes(Headset.maxLedsCount * 4);
    }

    public function ClearWithColor(color : Color){
        for( i in 0 ... Headset.maxLedsCount){
            this.setI32(i * 4, color.getInt());
        }
    }

    public function SetColor(index : Int, color : Color){
        if(index < Headset.maxLedsCount){
            this.setI32(index * 4, color.getInt());
        }
    }
}

class Mousepad{
    public static inline var maxLedsCount = 15;
}

abstract MousepadCustomEffect(hl.Bytes)
{
    public function new(){
        this = new hl.Bytes(Mousepad.maxLedsCount* 4);
    }

    public function ClearWithColor(color : Color){
        for( i in 0 ... Mousepad.maxLedsCount){
            this.setI32(i * 4, color.getInt());
        }
    }

    public function SetColor(index : Int, color : Color){
        if(index < Mousepad.maxLedsCount){
            this.setI32(index * 4, color.getInt());
        }
    }
}

class ChromaLink{
    public static inline var maxLedsCount = 5;
}

abstract ChromaLinkCustomEffect(hl.Bytes)
{
    public function new(){
        this = new hl.Bytes(ChromaLink.maxLedsCount* 4);
    }

    public function ClearWithColor(color : Color){
        for( i in 0 ... ChromaLink.maxLedsCount){
            this.setI32(i * 4, color.getInt());
        }
    }

    public function SetColor(index : Int, color : Color){
        if(index < ChromaLink.maxLedsCount){
            this.setI32(index * 4, color.getInt());
        }
    }
}

@:hlNative("chroma")
class Api{
    @:hlNative("chroma", "init")
    public static function init(){
    }

    @:hlNative("chroma", "release")
    public static function release(){
    }

    @:hlNative("chroma", "setMouseEffect")
    public static function setMouseEffect(effect : MouseCustomEffect){}

    @:hlNative("chroma", "setKeyboardEffect")
    public static function setKeyboardEffect(effect : KeyboardCustomEffect){}

    @:hlNative("chroma", "setMousepadEffect")
    public static function setMousepadEffect(effect : MousepadCustomEffect){}

    @:hlNative("chroma", "setKeypadEffect")
    public static function setKeypadEffect(effect : KeypadCustomEffect){}

    @:hlNative("chroma", "setHeadsetEffect")
    public static function setHeadsetEffect(effect : HeadsetCustomEffect){}

    @:hlNative("chroma", "setKeyboardKeysEffect")
    public static function setKeyboardKeysEffect(effect : KeyboardCustomKeyEffect){}

    @:hlNative("chroma", "setLinkedEffect")
    public static function setLinkedEffect(effect :KeyboardCustomEffect){}
}