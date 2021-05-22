DeclareModule _math_
  ;workaround for using the original pb-functions
  Macro Sin(a,m=):Sin#m(a):EndMacro
  Macro Cos(a,m=):Cos#m(a):EndMacro
  Macro Pow(a,b,m=):Pow#m(a,b):EndMacro
  Macro Exp(a,m=):exp#m(a):EndMacro
  Macro Log(a,m=):log#m(a):EndMacro
  Macro IsNAN(a,m=):IsNAN#m(a):EndMacro
  Macro Round(a,b,m=):round#m(a,b):EndMacro
  Macro Abs(a,m=):abs#m(a):EndMacro
  Macro Sign(a,m=):sign#m(a):EndMacro
  Macro Tan(a,m=):tan#m(a):EndMacro
  Macro ASin(a,m=):asin#m(a):EndMacro
  Macro ACos(a,m=):acos#m(a):EndMacro
  Macro ATan2(x,y,m=):ATan2#m(y,x):EndMacro;reverse order in c++!
  Macro ATan(x,m=):Atan#m(x):EndMacro
  Macro SinH(a,m=):SinH#m(a):EndMacro
  Macro CosH(a,m=):CosH#m(a):EndMacro
  Macro TanH(a,m=):TanH#m(a):EndMacro
  Macro ASinH(a,m=):ASinH#m(a):EndMacro
  Macro ACosH(a,m=):acosh#m(a):EndMacro
  Macro ATanH(a,m=):ATanH#m(a):EndMacro
  Macro Mod(a,b,m=):Mod#m(a,b):EndMacro
  Macro _typehelper(nb,dd)
    CompilerIf  (nb>>dd) & 1 = 1
      __type#dd#__.b[0]
    CompilerElse
      __type#dd#__.a[0]
    CompilerEndIf
  EndMacro
  Macro _typehelper2(nb,dd)
    ((TypeOf(nb\__type#dd#__)&1)<<dd)
  EndMacro
  Macro StructureAddType(nb)
    CompilerIf nb>%1111
      CompilerError "NB to big!"
    CompilerEndIf
    _math_::_typehelper(nb,0)
    _math_::_typehelper(nb,1)
    _math_::_typehelper(nb,2)
    _math_::_typehelper(nb,3)
    ;_math_::_typehelper(nb,4)
    ;_math_::_typehelper(nb,5)
    ;_math_::_typehelper(nb,6)
    ;_math_::_typehelper(nb,7)  
  EndMacro
  Macro IsNumber(a)
    ((_math::dq#a#_math::dq => "(" And _math::dq#a#_math::dq < ")") Or ;brace = number
     (_math::dq#a#_math::dq => "-" And _math::dq#a#_math::dq < ".") Or ;minus = negativ number
     (_math::dq#a#_math::dq => "0" And _math::dq#a#_math::dq < "9") )
  EndMacro
  Macro IsEmpty(a)
    (_math::dq#a#_math::dq = "")
  EndMacro
  Macro IsVariable(a)
    TypeOf(a) <> #PB_Structure
  EndMacro
EndDeclareModule
