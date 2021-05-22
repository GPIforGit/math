Module math
;-----------------------
;- func_exponential_inl.pbi
;{

; Structure longfloat
;   StructureUnion
;     l.l
;     f.f
;   EndStructureUnion
; EndStructure
Procedure.f pow_f(a.f,b.f)
  ProcedureReturn _math_::Pow(a,b)
EndProcedure
Procedure.f exp_f(a.f)
  ProcedureReturn _math_::Exp(a)
EndProcedure
Procedure.f log_f(a.f)
  ProcedureReturn _math_::Log(a)
EndProcedure
Procedure.f exp2_f(value.f)
  ProcedureReturn _math_::Exp(0.6931471805599453094 * value)
EndProcedure
Procedure.f log2_f(value.f)
  ProcedureReturn _math_::Log(value) * 1.4426950408889634074
EndProcedure
Procedure.f sqrt_f(a.f)
  ProcedureReturn Sqr(a)
EndProcedure
Procedure.f inversesqrt_f(f.f)
  ProcedureReturn 1.0 / Sqr(f)
  ; "fast" routine below - and in PB slower!
;   Protected.f half
;   Protected.longfloat i,*x  
;   *x = @f  
;   half = *x\f * 0.5
;   i\l = $5f375a86 - (*x\l >> 1)
;   ProcedureReturn i\f * (1.5 - half * i\f * i\f)
EndProcedure
; 
; CompilerIf #PB_Compiler_IsMainFile
;   a=ElapsedMilliseconds()
;   b.f
;   For I = 1 To 1000000
;     b+inversesqrt(i)
;   Next
;     
;   
;   MessageRequester("test",Str(ElapsedMilliseconds()-a)+ #LF$ + b)
; CompilerEndIf
;}
;-----------------------
;- func_common_inl.pbi
;{

Structure floatlong
  StructureUnion
    f.f
    l.l
  EndStructureUnion
EndStructure
Procedure.f frexp_f(value.f, *exp.float)
_math::assert(*exp <> #Null)
  Protected.floatlong f 
  Protected.l exp
  If value=0 Or _math_::IsNAN(value) Or IsInfinity(value)
    *exp\f=0
    ProcedureReturn 0
  EndIf
  f\f= value
  exp = (f\l >>23) & $ff -126
  *exp\f = exp
  f\l & ~($ff<<23)
  f\l | (126<<23)
  ProcedureReturn f\f
EndProcedure
Procedure.f ldexp_f(x.f,expf.f)
  Protected.floatlong f 
  If x=0 And expf=0
    ProcedureReturn 0
  EndIf
  Protected.l expl=expf
  expl= ((expl+ 126) & $ff) << 23
  f\f=x
  f\l & ~($ff<<23)
  f\l | expl
  ProcedureReturn f\f
EndProcedure
Procedure.f Modf_f(x.f, *retI.float)
_math::assert(*retI <> #Null)
  *reti\f = Int(x)
  ProcedureReturn x.f - *reti\f
EndProcedure
Procedure.f Mod_f(a.f, b.f)
  ProcedureReturn a - b * _math_::Round(a/b,#PB_Round_Down)
EndProcedure
Procedure.f clamp_f(x.f, min.f=0, max.f=1)
  If x < min
    ProcedureReturn min
  ElseIf x > max
    ProcedureReturn max
  EndIf
  ProcedureReturn x
EndProcedure
Procedure.f repeat_f(Texcoord.f)
  ProcedureReturn fract_f(Texcoord)
EndProcedure
Procedure.f mirrorClamp_f(Texcoord.f)
  ProcedureReturn fract_f(_math_::Abs(Texcoord))
EndProcedure
Procedure.f mirrorRepeat_f(Texcoord.f)
  Protected.f Abs = _math_::Abs(Texcoord)
	Protected.f Clamp = _math_::Mod(floor_f(Abs), 2)
	Protected.f Floor = floor_f(Abs)
	Protected.f Rest = Abs - Floor
	Protected.f Mirror = Clamp + Rest
	ProcedureReturn mix_f(Rest, 1 - Rest, Bool(Mirror >= 1))
EndProcedure
Procedure.f Trunc_f(x.f)
  If x < 0.0
    ProcedureReturn -_math_::Round(-x, #PB_Round_Down)
  EndIf
  ProcedureReturn _math_::Round(x, #PB_Round_Down)
EndProcedure
Procedure.f fract_f(x.f)
  ProcedureReturn x.f - _math_::Round(x.f, #PB_Round_Down)
EndProcedure
Procedure.f mix_f(x.f, y.f, a.f)
  ProcedureReturn x * (1.0 - a) + y * a
EndProcedure
Procedure.f roundEven_f(x.f)
  Protected.f IntegerPart = Int(x)
  Protected.f FractionalPart = fract_f(x)
  If FractionalPart > 0.5 Or FractionalPart < 0.5
    ProcedureReturn math::Round_f(x)
  ElseIf (Int(x) % 2) = 0
    ProcedureReturn IntegerPart
  ElseIf x <= 0
    ProcedureReturn IntegerPart - 1.0
  Else
    ProcedureReturn IntegerPart + 1.0
  EndIf
EndProcedure
Procedure.l equal_f(x.f,y.f,epsilon.f = #epsilon)
  ProcedureReturn Bool( _math_::Abs(x-y) < epsilon)
EndProcedure
Procedure.l notEqual_f(x.f,y.f,epsilon.f = #epsilon)
  ProcedureReturn Bool( _math_::Abs(x-y) >= epsilon)
EndProcedure
Procedure.f Round_f(x.f)
  ProcedureReturn _math_::Round(x,#PB_Round_Nearest)
EndProcedure
Procedure.f Floor_f(x.f)
  ProcedureReturn _math_::Round(x, #PB_Round_Down)
EndProcedure
Procedure.f Ceil_f(x.f)
  ProcedureReturn _math_::Round(x, #PB_Round_Up)
EndProcedure
Procedure.f Abs_f(x.f)
  ProcedureReturn _math_::Abs(x)
EndProcedure
Procedure.f sign_f(x.f)
  ProcedureReturn _math_::Sign(x)
EndProcedure
;}
;-----------------------
;- func_geometric_inl.pbi
;{

Procedure Vec3_Cross(*res.vec3, *x.Vec3, *y.vec3)
_math::assert(*res <> #Null And *x <> #Null And *y <> #Null)
  If *res = *x
    Protected.vec3 tmp
    set(tmp,*x)
    *x=@tmp
  EndIf  
  set_float(*res,
            (*x\y * *y\z - *y\y * *x\z),
            (*x\z * *y\x - *y\z * *x\x),
            (*x\x * *y\y - *y\x * *x\y))
EndProcedure
Procedure.f refract_f(i, n, eta)
  Protected.f dotValue = n * I
  Protected.f k = 1- eta * eta * (1 - dotValue * dotValue)
  ProcedureReturn (eta * I - (eta * dotValue + Sqr(K)) * n) * Bool( k>= 0)
EndProcedure
;}
;-----------------------
;- func_trigonometric_inl.pbi
;{

Procedure.f radians_f(x.f)
  ProcedureReturn Radian(x)
EndProcedure
Procedure.f degrees_f(x.f)
  ProcedureReturn Degree(x)
EndProcedure
Procedure.f sin_f(x.f)
  ProcedureReturn _math_::Sin(x)
EndProcedure
Procedure.f Cos_f(x.f)
  ProcedureReturn _math_::Cos(x)
EndProcedure
Procedure.f tan_f(x.f)
  ProcedureReturn _math_::Tan(x)
EndProcedure
Procedure.f asin_f(x.f)
  ProcedureReturn _math_::ASin(x)
EndProcedure
Procedure.f acos_f(x.f)
  ProcedureReturn _math_::ACos(x)
EndProcedure
Procedure.f ATan2_f(y.f, x.f)
  ProcedureReturn _math_::ATan2(y,x)
EndProcedure
Procedure.f SinH_f(x.f)
  ProcedureReturn _math_::SinH(x)
EndProcedure
Procedure.f CosH_f(x.f)
  ProcedureReturn _math_::CosH(x)
EndProcedure
Procedure.f TanH_f(x.f)
  ProcedureReturn _math_::TanH(x)
EndProcedure
Procedure.f ASinH_f(x.f)
  ProcedureReturn _math_::ASinH(x)
EndProcedure
Procedure.f acosh_f(x.f)
  ProcedureReturn _math_::ACosH(x)
EndProcedure
Procedure.f ATanH_f(x.f)
  ProcedureReturn _math_::ATanH(x)
EndProcedure
;}
;-----------------------
;- type_matrix_inl.pbi
;{

;- Mat2x2
Procedure Mat2x2_add(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec2_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec2_let(*res\column[1], *m1\v[1], +, *m2\v[1])
EndProcedure
Procedure Mat2x2_sub(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec2_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec2_let(*res\column[1], *m1\v[1], -, *m2\v[1])
EndProcedure
Procedure Mat2x2_mul_Mat2x2(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Protected.mat2x2 tmp
  If *res = *m1 And *res = *m2
    set(tmp, *m1)
    *m1=@tmp
    *m2=@tmp
  ElseIf *res=*m1    
    set(tmp, *m1)
    *m1=@tmp
  ElseIf *res=*m2
    set(tmp, *m2)
    *m2=@tmp
  EndIf
  Mat2x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1])
;
EndProcedure
Procedure Mat2x2_mul_Mat3x2(*res.Mat3x2, *m1.Mat2x2, *m2.Mat3x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1])
;
EndProcedure
Procedure Mat2x2_mul_Mat4x2(*res.Mat4x2, *m1.Mat2x2, *m2.Mat4x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1])
;
EndProcedure
Procedure Mat2x2_div(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Protected.Mat2x2 tmp
  Mat2x2_inverse(tmp, *m2)
  Mat2x2_mul_Mat2x2(*res, *m1, tmp)
EndProcedure
Procedure Mat2x2_div_Vec2(*res.vec2, *m.Mat2x2, *v.vec2)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  Protected.Mat2x2 tmp
  Mat2x2_inverse(tmp, *m)
  Mat2x2_mul_vec2(*res, tmp, *v)
EndProcedure
Procedure vec2_div_Mat2x2(*res.vec2, *v.vec2, *m.Mat2x2)
_math::assert(*res <> #Null And *v <> #Null And *m <> #Null)
  Protected.Mat2x2 tmp
  Mat2x2_inverse(tmp, *m)
  vec2_mul_Mat2x2(*res, *v, tmp)
EndProcedure
Procedure Mat2x2_mul_Vec2(*vecres.Vec2, *m.Mat2x2, *v.Vec2)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  If *vecres = *v
    Protected.vec2 tmp
    set(tmp, *v)
    *v=@tmp
  EndIf
  math::Vec2_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y)
EndProcedure
Procedure Vec2_mul_Mat2x2(*vecres.Vec2, *v.Vec2, *m.Mat2x2)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  If *vecres = *v
    Protected.vec2 tmp
    set(tmp, *v)
    *v=@tmp
  EndIf
  math::Vec2_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1])
EndProcedure
;- Mat2x3
Procedure Mat2x3_add(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec3_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec3_let(*res\column[1], *m1\v[1], +, *m2\v[1])
EndProcedure
Procedure Mat2x3_sub(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec3_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec3_let(*res\column[1], *m1\v[1], -, *m2\v[1])
EndProcedure
Procedure Mat2x3_mul_Mat2x2(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1])
;
EndProcedure
Procedure Mat2x3_mul_Mat3x2(*res.Mat3x3, *m1.Mat2x3, *m2.Mat3x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1])
;
EndProcedure
Procedure Mat2x3_mul_Mat4x2(*res.Mat4x3, *m1.Mat2x3, *m2.Mat4x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1],
             *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1])
;
EndProcedure
Procedure Mat2x3_mul_Vec2(*vecres.Vec3, *m.Mat2x3, *v.Vec2)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  math::Vec3_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y,
             *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y)
EndProcedure
Procedure Vec3_mul_Mat2x3(*vecres.Vec2, *v.Vec3, *m.Mat2x3)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  math::Vec2_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2])
EndProcedure
;- Mat2x4
Procedure Mat2x4_add(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec4_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec4_let(*res\column[1], *m1\v[1], +, *m2\v[1])
EndProcedure
Procedure Mat2x4_sub(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec4_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec4_let(*res\column[1], *m1\v[1], -, *m2\v[1])
EndProcedure
Procedure Mat2x4_mul_Mat2x2(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1])
;
EndProcedure
Procedure Mat2x4_mul_Mat3x2(*res.Mat3x4, *m1.Mat2x4, *m2.Mat3x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1],
             *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1])
;
EndProcedure
Procedure Mat2x4_mul_Mat4x2(*res.Mat4x4, *m1.Mat2x4, *m2.Mat4x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1],
             *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1],
             *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1],
             *m1\v[0]\f[3] * *m2\v[3]\f[0] + *m1\v[1]\f[3] * *m2\v[3]\f[1])
;
EndProcedure
Procedure Mat2x4_mul_Vec2(*vecres.Vec4, *m.Mat2x4, *v.Vec2)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  math::Vec4_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y,
             *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y,
             *m\v[0]\f[3] * *v\x + *m\v[1]\f[3] * *v\y)
EndProcedure
Procedure Vec4_mul_Mat2x4(*vecres.Vec2, *v.Vec4, *m.Mat2x4)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  math::Vec2_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2] + *v\w * *m\v[0]\f[3],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2] + *v\w * *m\v[1]\f[3])
EndProcedure
;- Mat3x2
Procedure Mat3x2_add(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec2_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec2_let(*res\column[1], *m1\v[1], +, *m2\v[1])
  vec2_let(*res\column[2], *m1\v[2], +, *m2\v[2])
EndProcedure
Procedure Mat3x2_sub(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec2_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec2_let(*res\column[1], *m1\v[1], -, *m2\v[1])
  vec2_let(*res\column[2], *m1\v[2], -, *m2\v[2])
EndProcedure
Procedure Mat3x2_mul_Mat2x3(*res.Mat2x2, *m1.Mat3x2, *m2.Mat2x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2])
;
EndProcedure
Procedure Mat3x2_mul_Mat3x3(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2])
;
EndProcedure
Procedure Mat3x2_mul_Mat4x3(*res.Mat4x2, *m1.Mat3x2, *m2.Mat4x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2])
;
EndProcedure
Procedure Mat3x2_mul_Vec3(*vecres.Vec2, *m.Mat3x2, *v.Vec3)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  math::Vec2_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z)
EndProcedure
Procedure Vec2_mul_Mat3x2(*vecres.Vec3, *v.Vec2, *m.Mat3x2)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  math::Vec3_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1],
             *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1])
EndProcedure
;- Mat3x3
Procedure Mat3x3_add(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec3_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec3_let(*res\column[1], *m1\v[1], +, *m2\v[1])
  vec3_let(*res\column[2], *m1\v[2], +, *m2\v[2])
EndProcedure
Procedure Mat3x3_sub(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec3_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec3_let(*res\column[1], *m1\v[1], -, *m2\v[1])
  vec3_let(*res\column[2], *m1\v[2], -, *m2\v[2])
EndProcedure
Procedure Mat3x3_mul_Mat2x3(*res.Mat2x3, *m1.Mat3x3, *m2.Mat2x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2])
;
EndProcedure
Procedure Mat3x3_mul_Mat3x3(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Protected.mat3x3 tmp
  If *res = *m1 And *res = *m2
    set(tmp, *m1)
    *m1=@tmp
    *m2=@tmp
  ElseIf *res=*m1    
    set(tmp, *m1)
    *m1=@tmp
  ElseIf *res=*m2
    set(tmp, *m2)
    *m2=@tmp
  EndIf
  Mat3x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2])
;
EndProcedure
Procedure Mat3x3_mul_Mat4x3(*res.Mat4x3, *m1.Mat3x3, *m2.Mat4x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2],
             *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2])
;
EndProcedure
Procedure Mat3x3_div(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Protected.Mat3x3 tmp
  Mat3x3_inverse(tmp, *m2)
  Mat3x3_mul_Mat3x3(*res, *m1, tmp)
EndProcedure
Procedure Mat3x3_div_Vec3(*res.vec3, *m.Mat3x3, *v.vec3)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  Protected.Mat3x3 tmp
  Mat3x3_inverse(tmp, *m)
  Mat3x3_mul_vec3(*res, tmp, *v)
EndProcedure
Procedure vec3_div_Mat3x3(*res.vec3, *v.vec3, *m.Mat3x3)
_math::assert(*res <> #Null And *v <> #Null And *m <> #Null)
  Protected.Mat3x3 tmp
  Mat3x3_inverse(tmp, *m)
  vec3_mul_Mat3x3(*res, *v, tmp)
EndProcedure
Procedure Mat3x3_mul_Vec3(*vecres.Vec3, *m.Mat3x3, *v.Vec3)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  If *vecres = *v
    Protected.vec3 tmp
    set(tmp, *v)
    *v=@tmp
  EndIf
  math::Vec3_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z,
             *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z)
EndProcedure
Procedure Vec3_mul_Mat3x3(*vecres.Vec3, *v.Vec3, *m.Mat3x3)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  If *vecres = *v
    Protected.vec3 tmp
    set(tmp, *v)
    *v=@tmp
  EndIf
  math::Vec3_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2],
             *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2])
EndProcedure
;- Mat3x4
Procedure Mat3x4_add(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec4_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec4_let(*res\column[1], *m1\v[1], +, *m2\v[1])
  vec4_let(*res\column[2], *m1\v[2], +, *m2\v[2])
EndProcedure
Procedure Mat3x4_sub(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec4_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec4_let(*res\column[1], *m1\v[1], -, *m2\v[1])
  vec4_let(*res\column[2], *m1\v[2], -, *m2\v[2])
EndProcedure
Procedure Mat3x4_mul_Mat2x3(*res.Mat2x4, *m1.Mat3x4, *m2.Mat2x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2])
;
EndProcedure
Procedure Mat3x4_mul_Mat3x3(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2],
             *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2])
;
EndProcedure
Procedure Mat3x4_mul_Mat4x3(*res.Mat4x4, *m1.Mat3x4, *m2.Mat4x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2],
             *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2],
             *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2],
             *m1\v[0]\f[3] * *m2\v[3]\f[0] + *m1\v[1]\f[3] * *m2\v[3]\f[1] + *m1\v[2]\f[3] * *m2\v[3]\f[2])
;
EndProcedure
Procedure Mat3x4_mul_Vec3(*vecres.Vec4, *m.Mat3x4, *v.Vec3)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  math::Vec4_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z,
             *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z,
             *m\v[0]\f[3] * *v\x + *m\v[1]\f[3] * *v\y + *m\v[2]\f[3] * *v\z)
EndProcedure
Procedure Vec4_mul_Mat3x4(*vecres.Vec3, *v.Vec4, *m.Mat3x4)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  math::Vec3_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2] + *v\w * *m\v[0]\f[3],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2] + *v\w * *m\v[1]\f[3],
             *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2] + *v\w * *m\v[2]\f[3])
EndProcedure
;- Mat4x2
Procedure Mat4x2_add(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec2_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec2_let(*res\column[1], *m1\v[1], +, *m2\v[1])
  vec2_let(*res\column[2], *m1\v[2], +, *m2\v[2])
  vec2_let(*res\column[3], *m1\v[3], +, *m2\v[3])
EndProcedure
Procedure Mat4x2_sub(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec2_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec2_let(*res\column[1], *m1\v[1], -, *m2\v[1])
  vec2_let(*res\column[2], *m1\v[2], -, *m2\v[2])
  vec2_let(*res\column[3], *m1\v[3], -, *m2\v[3])
EndProcedure
Procedure Mat4x2_mul_Mat2x4(*res.Mat2x2, *m1.Mat4x2, *m2.Mat2x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3])
;
EndProcedure
Procedure Mat4x2_mul_Mat3x4(*res.Mat3x2, *m1.Mat4x2, *m2.Mat3x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3])
;
EndProcedure
Procedure Mat4x2_mul_Mat4x4(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x2_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2] + *m1\v[3]\f[0] * *m2\v[3]\f[3],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2] + *m1\v[3]\f[1] * *m2\v[3]\f[3])
;
EndProcedure
Procedure Mat4x2_mul_Vec4(*vecres.Vec2, *m.Mat4x2, *v.Vec4)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  math::Vec2_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z + *m\v[3]\f[0] * *v\w,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z + *m\v[3]\f[1] * *v\w)
EndProcedure
Procedure Vec2_mul_Mat4x2(*vecres.Vec4, *v.Vec2, *m.Mat4x2)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  math::Vec4_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1],
             *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1],
             *v\x * *m\v[3]\f[0] + *v\y * *m\v[3]\f[1])
EndProcedure
;- Mat4x3
Procedure Mat4x3_add(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec3_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec3_let(*res\column[1], *m1\v[1], +, *m2\v[1])
  vec3_let(*res\column[2], *m1\v[2], +, *m2\v[2])
  vec3_let(*res\column[3], *m1\v[3], +, *m2\v[3])
EndProcedure
Procedure Mat4x3_sub(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec3_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec3_let(*res\column[1], *m1\v[1], -, *m2\v[1])
  vec3_let(*res\column[2], *m1\v[2], -, *m2\v[2])
  vec3_let(*res\column[3], *m1\v[3], -, *m2\v[3])
EndProcedure
Procedure Mat4x3_mul_Mat2x4(*res.Mat2x3, *m1.Mat4x3, *m2.Mat2x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3])
;
EndProcedure
Procedure Mat4x3_mul_Mat3x4(*res.Mat3x3, *m1.Mat4x3, *m2.Mat3x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3])
;
EndProcedure
Procedure Mat4x3_mul_Mat4x4(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat4x3_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2] + *m1\v[3]\f[0] * *m2\v[3]\f[3],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2] + *m1\v[3]\f[1] * *m2\v[3]\f[3],
             *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2] + *m1\v[3]\f[2] * *m2\v[3]\f[3])
;
EndProcedure
Procedure Mat4x3_mul_Vec4(*vecres.Vec3, *m.Mat4x3, *v.Vec4)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  math::Vec3_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z + *m\v[3]\f[0] * *v\w,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z + *m\v[3]\f[1] * *v\w,
             *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z + *m\v[3]\f[2] * *v\w)
EndProcedure
Procedure Vec3_mul_Mat4x3(*vecres.Vec4, *v.Vec3, *m.Mat4x3)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  math::Vec4_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2],
             *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2],
             *v\x * *m\v[3]\f[0] + *v\y * *m\v[3]\f[1] + *v\z * *m\v[3]\f[2])
EndProcedure
;- Mat4x4
Procedure Mat4x4_add(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec4_let(*res\column[0], *m1\v[0], +, *m2\v[0])
  vec4_let(*res\column[1], *m1\v[1], +, *m2\v[1])
  vec4_let(*res\column[2], *m1\v[2], +, *m2\v[2])
  vec4_let(*res\column[3], *m1\v[3], +, *m2\v[3])
EndProcedure
Procedure Mat4x4_sub(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  vec4_let(*res\column[0], *m1\v[0], -, *m2\v[0])
  vec4_let(*res\column[1], *m1\v[1], -, *m2\v[1])
  vec4_let(*res\column[2], *m1\v[2], -, *m2\v[2])
  vec4_let(*res\column[3], *m1\v[3], -, *m2\v[3])
EndProcedure
Procedure Mat4x4_mul_Mat2x4(*res.Mat2x4, *m1.Mat4x4, *m2.Mat2x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat2x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2] + *m1\v[3]\f[3] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2] + *m1\v[3]\f[3] * *m2\v[1]\f[3])
;
EndProcedure
Procedure Mat4x4_mul_Mat3x4(*res.Mat3x4, *m1.Mat4x4, *m2.Mat3x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Mat3x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2] + *m1\v[3]\f[3] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2] + *m1\v[3]\f[3] * *m2\v[1]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3],
             *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2] + *m1\v[3]\f[3] * *m2\v[2]\f[3])
;
EndProcedure
Procedure Mat4x4_mul_Mat4x4(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Protected.mat4x4 tmp
  If *res = *m1 And *res = *m2
    set(tmp, *m1)
    *m1=@tmp
    *m2=@tmp
  ElseIf *res=*m1    
    set(tmp, *m1)
    *m1=@tmp
  ElseIf *res=*m2
    set(tmp, *m2)
    *m2=@tmp
  EndIf
  Mat4x4_set(*res,
             *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3],
             *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3],
             *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3],
             *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2] + *m1\v[3]\f[3] * *m2\v[0]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3],
             *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3],
             *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3],
             *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2] + *m1\v[3]\f[3] * *m2\v[1]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3],
             *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3],
             *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3],
             *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2] + *m1\v[3]\f[3] * *m2\v[2]\f[3],
;
             *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2] + *m1\v[3]\f[0] * *m2\v[3]\f[3],
             *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2] + *m1\v[3]\f[1] * *m2\v[3]\f[3],
             *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2] + *m1\v[3]\f[2] * *m2\v[3]\f[3],
             *m1\v[0]\f[3] * *m2\v[3]\f[0] + *m1\v[1]\f[3] * *m2\v[3]\f[1] + *m1\v[2]\f[3] * *m2\v[3]\f[2] + *m1\v[3]\f[3] * *m2\v[3]\f[3])
;
EndProcedure
Procedure Mat4x4_div(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
_math::assert(*res <> #Null And *m1 <> #Null And *m2 <> #Null)
  Protected.Mat4x4 tmp
  Mat4x4_inverse(tmp, *m2)
  Mat4x4_mul_Mat4x4(*res, *m1, tmp)
EndProcedure
Procedure Mat4x4_div_Vec4(*res.vec4, *m.Mat4x4, *v.vec4)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  Protected.Mat4x4 tmp
  Mat4x4_inverse(tmp, *m)
  Mat4x4_mul_vec4(*res, tmp, *v)
EndProcedure
Procedure vec4_div_Mat4x4(*res.vec4, *v.vec4, *m.Mat4x4)
_math::assert(*res <> #Null And *v <> #Null And *m <> #Null)
  Protected.Mat4x4 tmp
  Mat4x4_inverse(tmp, *m)
  vec4_mul_Mat4x4(*res, *v, tmp)
EndProcedure
Procedure Mat4x4_mul_Vec4(*vecres.Vec4, *m.Mat4x4, *v.Vec4)
_math::assert(*vecres <> #Null And *m <> #Null And *v <> #Null)
  If *vecres = *v
    Protected.vec4 tmp
    set(tmp, *v)
    *v=@tmp
  EndIf
  math::Vec4_set(*vecres,
             *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z + *m\v[3]\f[0] * *v\w,
             *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z + *m\v[3]\f[1] * *v\w,
             *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z + *m\v[3]\f[2] * *v\w,
             *m\v[0]\f[3] * *v\x + *m\v[1]\f[3] * *v\y + *m\v[2]\f[3] * *v\z + *m\v[3]\f[3] * *v\w)
EndProcedure
Procedure Vec4_mul_Mat4x4(*vecres.Vec4, *v.Vec4, *m.Mat4x4)
_math::assert(*vecres <> #Null And *v <> #Null And *m <> #Null)
  If *vecres = *v
    Protected.vec4 tmp
    set(tmp, *v)
    *v=@tmp
  EndIf
  math::Vec4_set(*vecres,
             *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2] + *v\w * *m\v[0]\f[3],
             *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2] + *v\w * *m\v[1]\f[3],
             *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2] + *v\w * *m\v[2]\f[3],
             *v\x * *m\v[3]\f[0] + *v\y * *m\v[3]\f[1] + *v\z * *m\v[3]\f[2] + *v\w * *m\v[3]\f[3])
EndProcedure
;}
;-----------------------
;- func_matrix_inl.pbi
;{

Procedure Mat2x2_inverse(*res.Mat2x2, *m.Mat2x2)
_math::assert(*res <> #Null And *m <> #Null)
  Protected.f OneOverDeterminant = 1.0 / (*m\v[0]\f[0] * *m\v[1]\f[1]	- *m\v[1]\f[0] * *m\v[0]\f[1])
  If *res = *m
    Protected.mat2x2 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  mat2x2_set(*res,
             *m\v[1]\f[1] * OneOverDeterminant,
             - *m\v[0]\f[1] * OneOverDeterminant,
             - *m\v[1]\f[0] * OneOverDeterminant,
             *m\v[0]\f[0] * OneOverDeterminant)
EndProcedure
Procedure Mat3x3_inverse(*res.Mat3x3, *m.Mat3x3)  
_math::assert(*res <> #Null And *m <> #Null)
  Protected.f OneOverDeterminant = 1.0 / (*m\v[0]\f[0] * (*m\v[1]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[1]\f[2]) - *m\v[1]\f[0] * (*m\v[0]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[0]\f[2])	+ *m\v[2]\f[0] * (*m\v[0]\f[1] * *m\v[1]\f[2] - *m\v[1]\f[1] * *m\v[0]\f[2]))
  If *res = *m
    Protected.mat3x3 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] =   (*m\v[1]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[1]\f[2]) * OneOverDeterminant
  *res\v[1]\f[0] = - (*m\v[1]\f[0] * *m\v[2]\f[2] - *m\v[2]\f[0] * *m\v[1]\f[2]) * OneOverDeterminant
  *res\v[2]\f[0] =   (*m\v[1]\f[0] * *m\v[2]\f[1] - *m\v[2]\f[0] * *m\v[1]\f[1]) * OneOverDeterminant
  *res\v[0]\f[1] = - (*m\v[0]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[0]\f[2]) * OneOverDeterminant
  *res\v[1]\f[1] =   (*m\v[0]\f[0] * *m\v[2]\f[2] - *m\v[2]\f[0] * *m\v[0]\f[2]) * OneOverDeterminant
  *res\v[2]\f[1] = - (*m\v[0]\f[0] * *m\v[2]\f[1] - *m\v[2]\f[0] * *m\v[0]\f[1]) * OneOverDeterminant
  *res\v[0]\f[2] =   (*m\v[0]\f[1] * *m\v[1]\f[2] - *m\v[1]\f[1] * *m\v[0]\f[2]) * OneOverDeterminant
  *res\v[1]\f[2] = - (*m\v[0]\f[0] * *m\v[1]\f[2] - *m\v[1]\f[0] * *m\v[0]\f[2]) * OneOverDeterminant
  *res\v[2]\f[2] =   (*m\v[0]\f[0] * *m\v[1]\f[1] - *m\v[1]\f[0] * *m\v[0]\f[1]) * OneOverDeterminant
EndProcedure
Procedure Mat4x4_inverse(*res.mat4x4, *m.Mat4x4)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat4x4 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  Protected.f Coef00 = *m\v[2]\f[2] * *m\v[3]\f[3] - *m\v[3]\f[2] * *m\v[2]\f[3];
  Protected.f Coef02 = *m\v[1]\f[2] * *m\v[3]\f[3] - *m\v[3]\f[2] * *m\v[1]\f[3];
  Protected.f Coef03 = *m\v[1]\f[2] * *m\v[2]\f[3] - *m\v[2]\f[2] * *m\v[1]\f[3];
  Protected.f Coef04 = *m\v[2]\f[1] * *m\v[3]\f[3] - *m\v[3]\f[1] * *m\v[2]\f[3];
  Protected.f Coef06 = *m\v[1]\f[1] * *m\v[3]\f[3] - *m\v[3]\f[1] * *m\v[1]\f[3];
  Protected.f Coef07 = *m\v[1]\f[1] * *m\v[2]\f[3] - *m\v[2]\f[1] * *m\v[1]\f[3];
  Protected.f Coef08 = *m\v[2]\f[1] * *m\v[3]\f[2] - *m\v[3]\f[1] * *m\v[2]\f[2];
  Protected.f Coef10 = *m\v[1]\f[1] * *m\v[3]\f[2] - *m\v[3]\f[1] * *m\v[1]\f[2];
  Protected.f Coef11 = *m\v[1]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[1]\f[2];
  Protected.f Coef12 = *m\v[2]\f[0] * *m\v[3]\f[3] - *m\v[3]\f[0] * *m\v[2]\f[3];
  Protected.f Coef14 = *m\v[1]\f[0] * *m\v[3]\f[3] - *m\v[3]\f[0] * *m\v[1]\f[3];
  Protected.f Coef15 = *m\v[1]\f[0] * *m\v[2]\f[3] - *m\v[2]\f[0] * *m\v[1]\f[3];
  Protected.f Coef16 = *m\v[2]\f[0] * *m\v[3]\f[2] - *m\v[3]\f[0] * *m\v[2]\f[2];
  Protected.f Coef18 = *m\v[1]\f[0] * *m\v[3]\f[2] - *m\v[3]\f[0] * *m\v[1]\f[2];
  Protected.f Coef19 = *m\v[1]\f[0] * *m\v[2]\f[2] - *m\v[2]\f[0] * *m\v[1]\f[2];
  Protected.f Coef20 = *m\v[2]\f[0] * *m\v[3]\f[1] - *m\v[3]\f[0] * *m\v[2]\f[1];
  Protected.f Coef22 = *m\v[1]\f[0] * *m\v[3]\f[1] - *m\v[3]\f[0] * *m\v[1]\f[1];
  Protected.f Coef23 = *m\v[1]\f[0] * *m\v[2]\f[1] - *m\v[2]\f[0] * *m\v[1]\f[1];
  Protected.vec4 Fac0, Fac1, Fac2, Fac3, Fac4, Fac5
  Protected.vec4 VecA, VecB, VecC, VecD
  Protected.vec4 Inv0, Inv1, Inv2, Inv3
  Protected.vec4 SignA, SignB
  Protected.vec4 tmp1, tmp2, tmp3
  set_float( Fac0, Coef00, Coef00, Coef02, Coef03)
  set_float( Fac1, Coef04, Coef04, Coef06, Coef07)
  set_float( Fac2, Coef08, Coef08, Coef10, Coef11)
  set_float( Fac3, Coef12, Coef12, Coef14, Coef15)
  set_float( Fac4, Coef16, Coef16, Coef18, Coef19)
  set_float( Fac5, Coef20, Coef20, Coef22, Coef23)
  set_float( VecA, *m\v[1]\f[0], *m\v[0]\f[0], *m\v[0]\f[0], *m\v[0]\f[0])
  set_float( VecB, *m\v[1]\f[1], *m\v[0]\f[1], *m\v[0]\f[1], *m\v[0]\f[1])
  set_float( VecC, *m\v[1]\f[2], *m\v[0]\f[2], *m\v[0]\f[2], *m\v[0]\f[2])
  set_float( VecD, *m\v[1]\f[3], *m\v[0]\f[3], *m\v[0]\f[3], *m\v[0]\f[3])
  mul(tmp1, VecB, Fac0)
  mul(tmp2, VecC, Fac1)
  mul(tmp3, VecD, Fac2)
  sub(Inv0, tmp1, tmp2):add(inv0, inv0, tmp3)
  mul(tmp1, VecA, Fac0)
  mul(tmp2, VecC, Fac3)
  mul(tmp3, VecD, Fac4)
  sub(Inv1, tmp1, tmp2):add(inv1, inv1, tmp3)
  mul(tmp1, VecA, Fac1)
  mul(tmp2, VecB, Fac3)
  mul(tmp3, VecD, Fac5)
  sub(Inv2, tmp1, tmp2):add(inv2, inv2, tmp3)
  mul(tmp1, VecA, Fac2)
  mul(tmp2, VecB, Fac4)
  mul(tmp3, VecC, Fac5)
  sub(Inv3, tmp1, tmp2):add(inv3, inv3, tmp3)
  set_float( SignA,  1, -1,  1, -1)
  set_float( SignB, -1,  1, -1,  1)
  vec4_let( *res\v[0], Inv0, *, SignA)
  vec4_let( *res\v[1], Inv1, *, SignB)
  vec4_let( *res\v[2], Inv2, *, SignA)
  vec4_let( *res\v[3], Inv3, *, SignB)
  Protected.vec4 Row0, Dot0
  set_float(Row0, *res\v[0]\f[0], *res\v[1]\f[0], *res\v[2]\f[0], *res\v[3]\f[0])
  vec4_mul(Dot0, *m\v[0], Row0)
  Protected.f Dot1 = (Dot0\x + Dot0\y) + (Dot0\z + Dot0\w)
  Protected.f OneOverDeterminant = 1.0 / Dot1
  let_Scalar(*res, *res, *, OneOverDeterminant)
EndProcedure
Procedure mat2x2_transpose(*res.mat2x2, *m.mat2x2)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat2x2 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
EndProcedure
Procedure mat2x3_transpose(*res.mat2x3, *m.mat3x2)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat3x2 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
EndProcedure
Procedure mat2x4_transpose(*res.mat2x4, *m.mat4x2)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat4x2 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[0]\f[3] = *m\v[3]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
  *res\v[1]\f[3] = *m\v[3]\f[1]
EndProcedure
Procedure mat3x2_transpose(*res.mat3x2, *m.mat2x3)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat2x3 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
EndProcedure
Procedure mat3x3_transpose(*res.mat3x3, *m.mat3x3)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat3x3 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
  *res\v[2]\f[2] = *m\v[2]\f[2]
EndProcedure
Procedure mat3x4_transpose(*res.mat3x4, *m.mat4x3)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat4x3 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[0]\f[3] = *m\v[3]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
  *res\v[1]\f[3] = *m\v[3]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = *m\v[3]\f[2]
EndProcedure
Procedure mat4x2_transpose(*res.mat4x2, *m.mat2x4)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat2x4 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
  *res\v[3]\f[0] = *m\v[0]\f[3]
  *res\v[3]\f[1] = *m\v[1]\f[3]
EndProcedure
Procedure mat4x3_transpose(*res.mat4x3, *m.mat3x4)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat3x4 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[3]\f[0] = *m\v[0]\f[3]
  *res\v[3]\f[1] = *m\v[1]\f[3]
  *res\v[3]\f[2] = *m\v[2]\f[3]
EndProcedure
Procedure mat4x4_transpose(*res.mat4x4, *m.mat4x4)
_math::assert(*res <> #Null And *m <> #Null)
  If *res = *m
    Protected.mat4x4 tmp
    set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[0]\f[3] = *m\v[3]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
  *res\v[1]\f[3] = *m\v[3]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = *m\v[3]\f[2]
  *res\v[3]\f[0] = *m\v[0]\f[3]
  *res\v[3]\f[1] = *m\v[1]\f[3]
  *res\v[3]\f[2] = *m\v[2]\f[3]
  *res\v[3]\f[3] = *m\v[3]\f[3]
EndProcedure
Procedure.f mat2x2_determinant(*m.mat2x2)
_math::assert(*m <> #Null)
  ProcedureReturn *m\v[0]\f[0] * *m\v[1]\f[1] - *m\v[1]\f[0] * *m\v[0]\f[1]
EndProcedure
Procedure.f mat3x3_determinant(*m.mat3x3)
_math::assert(*m <> #Null)
  ProcedureReturn *m\v[0]\f[0] * (*m\v[1]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[1]\f[2]) - *m\v[1]\f[0] * (*m\v[0]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[0]\f[2])	+ *m\v[2]\f[0] * (*m\v[0]\f[1] * *m\v[1]\f[2] - *m\v[1]\f[1] * *m\v[0]\f[2])
EndProcedure
Procedure.f mat4x4_determinant(*m.mat4x4)
_math::assert(*m <> #Null)
  Protected.f SubFactor00 = *m\v[2]\f[2] * *m\v[3]\f[3] - *m\v[3]\f[2] * *m\v[2]\f[3];
  Protected.f SubFactor01 = *m\v[2]\f[1] * *m\v[3]\f[3] - *m\v[3]\f[1] * *m\v[2]\f[3];
  Protected.f SubFactor02 = *m\v[2]\f[1] * *m\v[3]\f[2] - *m\v[3]\f[1] * *m\v[2]\f[2];
  Protected.f SubFactor03 = *m\v[2]\f[0] * *m\v[3]\f[3] - *m\v[3]\f[0] * *m\v[2]\f[3];
  Protected.f SubFactor04 = *m\v[2]\f[0] * *m\v[3]\f[2] - *m\v[3]\f[0] * *m\v[2]\f[2];
  Protected.f SubFactor05 = *m\v[2]\f[0] * *m\v[3]\f[1] - *m\v[3]\f[0] * *m\v[2]\f[1];
  Protected.vec4 DetCof
  set_float(DetCof,  
          (*m\v[1]\f[1] * SubFactor00 - *m\v[1]\f[2] * SubFactor01 + *m\v[1]\f[3] * SubFactor02),
          - (*m\v[1]\f[0] * SubFactor00 - *m\v[1]\f[2] * SubFactor03 + *m\v[1]\f[3] * SubFactor04),
          (*m\v[1]\f[0] * SubFactor01 - *m\v[1]\f[1] * SubFactor03 + *m\v[1]\f[3] * SubFactor05),
          - (*m\v[1]\f[0] * SubFactor02 - *m\v[1]\f[1] * SubFactor04 + *m\v[1]\f[2] * SubFactor05))
  ProcedureReturn		*m\v[0]\f[0] * DetCof\f[0] + *m\v[0]\f[1] * DetCof\f[1] +	*m\v[0]\f[2] * DetCof\f[2] + *m\v[0]\f[3] * DetCof\f[3]
EndProcedure
			
;}
;-----------------------
;- matrix_clip_space_inl.pbi
;{

Procedure ortho2(*res.mat4x4, left.f, right.f, bottom.f, top.f)
_math::assert(*res <> #Null)
  set_float(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = - (1)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
EndProcedure
Procedure orthoLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  set_float(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = (1) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - zNear / (zFar - zNear)
EndProcedure
Procedure orthoLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  set_float(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = (2) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - (zFar + zNear) / (zFar - zNear)
EndProcedure
Procedure orthoRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  set_float(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = - (1) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - zNear / (zFar - zNear)
EndProcedure
Procedure orthoRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  set_float(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = - (2) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - (zFar + zNear) / (zFar - zNear)
EndProcedure
Procedure orthoZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  orthoRH_ZO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure orthoNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  orthoRH_NO(*res.mat4x4, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure orthoLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  orthoLH_NO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure orthoRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  orthoRH_NO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure ortho(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  orthoRH_NO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure frustumLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = farVal / (farVal - nearVal)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = -(farVal * nearVal) / (farVal - nearVal)
EndProcedure
Procedure frustumLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = (farVal + nearVal) / (farVal - nearVal)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - ((2) * farVal * nearVal) / (farVal - nearVal)
EndProcedure
Procedure frustumRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = farVal / (nearVal - farVal)
  *res\v[2]\f[3] = (-1)
  *res\v[3]\f[2] = -(farVal * nearVal) / (farVal - nearVal)
EndProcedure
Procedure frustumRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = - (farVal + nearVal) / (farVal - nearVal)
  *res\v[2]\f[3] = (-1)
  *res\v[3]\f[2] = - ((2) * farVal * nearVal) / (farVal - nearVal)
EndProcedure
Procedure frustumZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  frustumRH_ZO(*res,left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustumNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  frustumRH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustumLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  frustumLH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustumRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  frustumRH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustum(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
_math::assert(*res <> #Null)
  frustumRH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure perspectiveRH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected.f tanHalfFovy = _math_::Tan(fovy / 2)
  set_float(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = zFar / (zNear - zFar)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveRH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected.f tanHalfFovy = _math_::Tan(fovy / 2)
  set_float(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = - (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveLH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected.f tanHalfFovy = _math_::Tan(fovy / 2)
  set_float(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = zFar / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveLH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected tanHalfFovy = _math_::Tan(fovy / 2)
  set_float(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveRH_ZO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspectiveNO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveRH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveLH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure      
Procedure perspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveRH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveRH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspectiveFovRH_ZO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;///todo max(width , Height) / min(width , Height)?
  set_float(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = zFar / (zNear - zFar)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveFovRH_NO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;todo max(width , Height) / min(width , Height)?
  set_float(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = - (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveFovLH_ZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;todo max(width , Height) / min(width , Height)?
  set_float(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = zFar / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveFovLH_NO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;todo max(width , Height) / min(width , Height)?
  set_float(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
EndProcedure
Procedure perspectiveFovZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveFovRH_ZO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFovNO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveFovRH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFovLH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveFovLH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFovRH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveFovRH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFov(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
_math::assert(*res <> #Null)
  perspectiveFovRH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure infinitePerspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
_math::assert(*res <> #Null)
  Protected.f range = _math_::Tan(fovy / 2) * zNear
  Protected.f left = -range * aspect
  Protected.f right = range * aspect
  Protected.f bottom = -range
  Protected.f top = range
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * zNear) / (right - left)
  *res\v[1]\f[1] = ((2) * zNear) / (top - bottom)
  *res\v[2]\f[2] = - (1)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = - (2) * zNear
EndProcedure
Procedure infinitePerspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
_math::assert(*res <> #Null)
  Protected.f range = _math_::Tan(fovy / 2) * zNear
  Protected.f left = -range * aspect
  Protected.f right = range * aspect
  Protected.f bottom = -range
  Protected.f top = range
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * zNear) / (right - left)
  *res\v[1]\f[1] = ((2) * zNear) / (top - bottom)
  *res\v[2]\f[2] = (1)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - (2) * zNear
EndProcedure
Procedure infinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f)
_math::assert(*res <> #Null)
  infinitePerspectiveRH(*res, fovy, aspect, zNear)
EndProcedure
; Infinite projection matrix: http://www.terathon.com/gdc07_lengyel.pdf
Procedure tweakedInfinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, ep.f=#epsilon)
_math::assert(*res <> #Null)
  Protected.f range = _math_::Tan(fovy / 2) * zNear
  Protected.f left = -range * aspect
  Protected.f right = range * aspect
  Protected.f bottom = -range
  Protected.f top = range
  set_float(*res,0)
  *res\v[0]\f[0] = ((2) * zNear) / (right - left)
  *res\v[1]\f[1] = ((2) * zNear) / (top - bottom)
  *res\v[2]\f[2] = ep - (1)
  *res\v[2]\f[3] = (-1)
  *res\v[3]\f[2] = (ep - (2)) * zNear
EndProcedure
;}
;-----------------------
;- matrix_projection_inl.pbi
;{

Procedure projectZO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
_math::assert(*res <> #Null And *obj <> #Null And *model <> #Null And *proj <> #Null And *viewport <> #Null)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  mul(tmp, *model, tmp)
  mul(tmp, *proj, tmp)
  let_Scalar(tmp, tmp, /, tmp\w)
  tmp\x = tmp\x * 0.5 + 0.5
  tmp\y = tmp\y * 0.5 + 0.5
  tmp\f[0] = tmp\f[0] * *viewport\f[2] + *viewport\f[0]
  tmp\f[1] = tmp\f[1] * *viewport\f[3] + *viewport\f[1]
  set(*res, tmp)
EndProcedure
Procedure projectNO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
_math::assert(*res <> #Null And *obj <> #Null And *model <> #Null And *proj <> #Null And *viewport <> #Null)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  mul(tmp, *model, tmp)
  mul(tmp, *proj, tmp)
  let_Scalar(tmp, tmp, /, tmp\w)
  let_scalar(tmp, tmp, *, 0.5)
  let_Scalar(tmp, tmp, +, 0.5)
  tmp\f[0] = tmp\f[0] * *viewport\f[2] + *viewport\f[0]
  tmp\f[1] = tmp\f[1] * *viewport\f[3] + *viewport\f[1]
  set(*res, tmp)
EndProcedure
Procedure project(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
_math::assert(*res <> #Null And *obj <> #Null And *model <> #Null And *proj <> #Null And *viewport <> #Null)
  projectNO(*res, *obj, *model, *proj, *viewport)
EndProcedure
Procedure unProjectZO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)	
_math::assert(*res <> #Null And *win <> #Null And *model <> #Null And *proj <> #Null And *viewport <> #Null)
  Protected.mat4x4 Inverse 
  mul(Inverse, *proj, *model)
  inverse(Inverse, Inverse)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  tmp\x = (tmp\x - *viewport\f[0]) / *viewport\f[2]
  tmp\y = (tmp\y - *viewport\f[1]) / *viewport\f[3]
  tmp\x = tmp\x * 2 - 1
  tmp\y = tmp\y * 2 - 1
  Protected.vec4 obj
  mul(obj, Inverse, tmp)
  let_Scalar(obj, obj, /, obj\w)
  set(*res, obj)
EndProcedure
Procedure unProjectNO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
_math::assert(*res <> #Null And *win <> #Null And *model <> #Null And *proj <> #Null And *viewport <> #Null)
  Protected.mat4x4 Inverse 
  mul(Inverse, *proj, *model)
  inverse(Inverse, Inverse)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  tmp\x = (tmp\x - *viewport\f[0]) / *viewport\f[2]
  tmp\y = (tmp\y - *viewport\f[1]) / *viewport\f[3]
  let_Scalar(tmp, tmp, *, 2)
  let_Scalar(tmp, tmp, -, 1)
  Protected.vec4 obj
  mul(obj, Inverse, tmp)
  let_Scalar(obj, obj, /, obj\w)
  set(*res, obj)
EndProcedure
Procedure unProject(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
_math::assert(*res <> #Null And *win <> #Null And *model <> #Null And *proj <> #Null And *viewport <> #Null)
  unProjectNO(*res, *win, *model, *proj, *viewport)
EndProcedure
Procedure pickMatrix(*res.mat4x4, *center.vec2, *delta.vec2, *viewport.vec4)
_math::assert(*res <> #Null And *center <> #Null And *delta <> #Null And *viewport <> #Null)
  _math::assert(*delta\x > 0 And *delta\y > 0)
  set_float(*res, 1)
  If Not( *delta\x > 0 And *delta\y > 0)
    ProcedureReturn; Error
  EndIf
  Protected.vec3 Temp
  set_float(temp,
      (*viewport\f[2] - 2 * (*center\x - *viewport\f[0])) / *delta\x,
      (*viewport\f[3] - 2 * (*center\y - *viewport\f[1])) / *delta\y,
      0)
  ; Translate And scale the picked region To the entire window
  translate(*res, *res, Temp)
  set_float(Temp, *viewport\f[2] / *delta\x, *viewport\f[3] / *delta\y, 1)		
  scale(*res, *res, Temp)
EndProcedure
;}
;-----------------------
;- matrix_transform_inl.pbi
;{

Procedure translate(*res.mat4x4, *m.mat4x4, *v.vec3)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  set(*res, *m)
  Protected.vec4 tmp,result
  ;Result[3] = m[0] * v[0] + m[1] * v[1] + m[2] * v[2] + m[3]
  vec4_let_Scalar(result, *m\v[0], *, *v\f[0])
  vec4_let_Scalar(tmp,    *m\v[1], *, *v\f[1])
  vec4_add(result,        result , tmp)
  vec4_let_Scalar(tmp,    *m\v[2], *, *v\f[2])
  vec4_add(result,        result , tmp)
  vec4_add(result,        result , *m\v[3])
  vec4_set_vec4(*res\v[3], result)
EndProcedure
Procedure mat4x4_rotate(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  If *res = *m
    Protected.mat4x4 tmpM
    set(tmpM, *m)
    *m = @tmpM
  EndIf
  Protected.f c = _math_::Cos(angle)
  Protected.f s = _math_::Sin(angle)
  Protected.vec3 axis
  normalize(axis, *v)
  Protected.vec3 temp
  Scalar_let(temp, 1-c, *, axis)
  Protected.mat4x4 Rotate
  Rotate\v[0]\f[0] = c + temp\f[0] * axis\f[0]
  Rotate\v[0]\f[1] =     temp\f[0] * axis\f[1] + s * axis\f[2]
  Rotate\v[0]\f[2] =     temp\f[0] * axis\f[2] - s * axis\f[1]
  Rotate\v[1]\f[0] =     temp\f[1] * axis\f[0] - s * axis\f[2]
  Rotate\v[1]\f[1] = c + temp\f[1] * axis\f[1]
  Rotate\v[1]\f[2] =     temp\f[1] * axis\f[2] + s * axis\f[0]
  Rotate\v[2]\f[0] =     temp\f[2] * axis\f[0] + s * axis\f[1]
  Rotate\v[2]\f[1] =     temp\f[2] * axis\f[1] - s * axis\f[0]
  Rotate\v[2]\f[2] = c + temp\f[2] * axis\f[2]
  Protected.vec4 tmp
  ;Result[0] = m[0] * Rotate[0][0] + m[1] * Rotate[0][1] + m[2] * Rotate[0][2];
  vec4_let_Scalar( *res\v[0], *m\v[0]   , *, Rotate\v[0]\f[0])
  vec4_let_Scalar( tmp      , *m\v[1]   , *, Rotate\v[0]\f[1])
  vec4_add(        *res\v[0], *res\v[0] , tmp)
  vec4_let_Scalar( tmp      , *m\v[2]   , *, Rotate\v[0]\f[2])
  vec4_add(        *res\v[0], *res\v[0] , tmp)
  ;Result[1] = m[0] * Rotate[1][0] + m[1] * Rotate[1][1] + m[2] * Rotate[1][2];
  vec4_let_Scalar( *res\v[1], *m\v[0]   , *, Rotate\v[1]\f[0])
  vec4_let_Scalar( tmp      , *m\v[1]   , *, Rotate\v[1]\f[1])
  vec4_add(        *res\v[1], *res\v[1] , tmp)
  vec4_let_Scalar( tmp      , *m\v[2]   , *, Rotate\v[1]\f[2])
  vec4_add(        *res\v[1], *res\v[1] , tmp)
  ;Result[2] = m[0] * Rotate[2][0] + m[1] * Rotate[2][1] + m[2] * Rotate[2][2];
  vec4_let_Scalar( *res\v[2], *m\v[0]   , *, Rotate\v[2]\f[0])
  vec4_let_Scalar( tmp      , *m\v[1]   , *, Rotate\v[2]\f[1])
  vec4_add(        *res\v[2], *res\v[2] , tmp)
  vec4_let_Scalar( tmp      , *m\v[2]   , *, Rotate\v[2]\f[2])
  vec4_add(        *res\v[2], *res\v[2] , tmp)
  ;Result[3] = m[3];
  vec4_set_vec4(   *res\v[3], *m\v[3])
EndProcedure
Procedure rotate_slow(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  Protected.f a = angle
  Protected.f c = _math_::Cos(a)
  Protected.f s = _math_::Sin(a)
  Protected.vec3 axis
  normalize(axis, *v)
  Protected.mat4x4 result
  result\v[0]\f[0] = c + (1 - c)      * axis\x     * axis\x
  result\v[0]\f[1] = (1 - c) * axis\x * axis\y + s * axis\z
  result\v[0]\f[2] = (1 - c) * axis\x * axis\z - s * axis\y
  result\v[0]\f[3] = 0
  result\v[1]\f[0] = (1 - c) * axis\y * axis\x - s * axis\z
  result\v[1]\f[1] = c + (1 - c) * axis\y * axis\y
  result\v[1]\f[2] = (1 - c) * axis\y * axis\z + s * axis\x
  result\v[1]\f[3] = 0
  result\v[2]\f[0] = (1 - c) * axis\z * axis\x + s * axis\y
  result\v[2]\f[1] = (1 - c) * axis\z * axis\y - s * axis\x
  result\v[2]\f[2] = c + (1 - c) * axis\z * axis\z
  result\v[2]\f[3] = 0
  result\v[3]\f[0] = 0
  result\v[3]\f[1] = 0
  result\v[3]\f[2] = 0
  result\v[3]\f[3] = 1
  mul(*res, *m, result)
EndProcedure
Procedure scale(*res.mat4x4, *m.mat4x4, *v.vec3)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  vec4_let_Scalar(*res\v[0], *m\v[0], *, *v\f[0])
  vec4_let_Scalar(*res\v[1], *m\v[1], *, *v\f[1])
  vec4_let_Scalar(*res\v[2], *m\v[2], *, *v\f[2])
  vec4_set_vec4  (*res\v[3], *m\v[3])
EndProcedure
Procedure scale_slow(*res.mat4x4, *m.mat4x4, *v.vec3)
_math::assert(*res <> #Null And *m <> #Null And *v <> #Null)
  Protected.mat4x4 Result
  set_float(Result, 1)
  Result\v[0]\f[0] = *v\x
  Result\v[1]\f[1] = *v\y
  Result\v[2]\f[2] = *v\z
  mul(*res, *m, Result)
EndProcedure
Procedure mat4x4_lookAtRH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
_math::assert(*res <> #Null And *eye <> #Null And *center <> #Null And *up <> #Null)
  Protected.vec3 f
  sub(f, *center, *eye)
  normalize(f,f)
  Protected.vec3 s
  cross(s, f, *up)
  normalize(s,s)	  
  Protected.vec3 u
  cross(u, s, f)
  set_float(*res, 1)
  *res\v[0]\f[0] = s\x
  *res\v[1]\f[0] = s\y
  *res\v[2]\f[0] = s\z
  *res\v[0]\f[1] = u\x
  *res\v[1]\f[1] = u\y
  *res\v[2]\f[1] = u\z
  *res\v[0]\f[2] =-f\x
  *res\v[1]\f[2] =-f\y
  *res\v[2]\f[2] =-f\z
  *res\v[3]\f[0] =-dot(s, *eye)
  *res\v[3]\f[1] =-dot(u, *eye)
  *res\v[3]\f[2] = dot(f, *eye)
EndProcedure
Procedure mat4x4_lookAtLH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
_math::assert(*res <> #Null And *eye <> #Null And *center <> #Null And *up <> #Null)
  Protected.vec3 f
  sub(f, *center, *eye)
  normalize(f,f)	  
  Protected.vec3 s
  cross(s, *up, f)
  normalize(s, s)
  Protected.vec3 u
  cross(u, f, s)	  
  set_float(*res, 1)
  *res\v[0]\f[0] = s\x
  *res\v[1]\f[0] = s\y
  *res\v[2]\f[0] = s\z
  *res\v[0]\f[1] = u\x
  *res\v[1]\f[1] = u\y
  *res\v[2]\f[1] = u\z
  *res\v[0]\f[2] = f\x
  *res\v[1]\f[2] = f\y
  *res\v[2]\f[2] = f\z
  *res\v[3]\f[0] = -dot(s, *eye)
  *res\v[3]\f[1] = -dot(u, *eye)
  *res\v[3]\f[2] = -dot(f, *eye)
EndProcedure
Procedure mat4x4_lookAt(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
_math::assert(*res <> #Null And *eye <> #Null And *center <> #Null And *up <> #Null)
  lookAtRH(*res, *eye, *center, *up)
EndProcedure
;}
;-----------------------
;- type_quat_inl.pbi
;{

Procedure Quat_set_vec3_vec3(*res.quat, *u.vec3, *v.vec3)
_math::assert(*res <> #Null And *u <> #Null And *v <> #Null)
  Protected.f norm_u_norm_v = Sqr(dot(*u, *u) * dot(*v, *v))
  Protected.f real_part = norm_u_norm_v + dot(*u, *v)
  Protected.vec3 t
  If real_part < 1.e-6 * norm_u_norm_v
    ; If u And v are exactly opposite, rotate 180 degrees
    ; around an arbitrary orthogonal axis. Axis normalisation
    ; can happen later, when we normalise the quaternion.
    real_part = 0
    If _math_::Abs(*u\x) > _math_::Abs(*u\z)
      set_float(t, -*u\y, *u\x, 0) 
    Else
      set_float(t, 0, -*u\z, *u\y)
    EndIf
  Else
    ; Otherwise, build quaternion the standard way.
    cross(t, *u, *v)
  EndIf
  set_float(*res, real_part, t\x, t\y, t\z)
  normalize(*res, *res)
EndProcedure
Procedure quat_set_eulerAngle(*res.quat, *eulerAngle.vec3)
_math::assert(*res <> #Null And *eulerAngle <> #Null)
  Protected.vec3 c,s
  let_scalar(c, *eulerAngle, *, 0.5)
  let_scalar(s, *eulerAngle, *, 0.5)
  Cos(c, c)
  Sin(s, s)
  *res\w = c\x * c\y * c\z + s\x * s\y * s\z
  *res\x = s\x * c\y * c\z - c\x * s\y * s\z
  *res\y = c\x * s\y * c\z + s\x * c\y * s\z
  *res\z = c\x * c\y * s\z - s\x * s\y * c\z
EndProcedure
Procedure quat_set_mat3x3(*res.quat, *m.mat3x3)
_math::assert(*res <> #Null And *m <> #Null)
  Protected.f fourXSquaredMinus1 = *m\v[0]\f[0] - *m\v[1]\f[1] - *m\v[2]\f[2]
  Protected.f fourYSquaredMinus1 = *m\v[1]\f[1] - *m\v[0]\f[0] - *m\v[2]\f[2]
  Protected.f fourZSquaredMinus1 = *m\v[2]\f[2] - *m\v[0]\f[0] - *m\v[1]\f[1]
  Protected.f fourWSquaredMinus1 = *m\v[0]\f[0] + *m\v[1]\f[1] + *m\v[2]\f[2]
  Protected.l biggestIndex = 0
  Protected.f fourBiggestSquaredMinus1 = fourWSquaredMinus1
  If fourXSquaredMinus1 > fourBiggestSquaredMinus1
    fourBiggestSquaredMinus1 = fourXSquaredMinus1
    biggestIndex = 1
  EndIf
  If fourYSquaredMinus1 > fourBiggestSquaredMinus1
    fourBiggestSquaredMinus1 = fourYSquaredMinus1
    biggestIndex = 2
  EndIf
  If fourZSquaredMinus1 > fourBiggestSquaredMinus1
    fourBiggestSquaredMinus1 = fourZSquaredMinus1
    biggestIndex = 3
  EndIf
  Protected.f biggestVal = Sqr(fourBiggestSquaredMinus1 + 1) * 0.5
  Protected.f mult = 0.25 / biggestVal
  Select biggestIndex
    Case 0
      set_float(*res, biggestVal, (*m\v[1]\f[2] - *m\v[2]\f[1]) * mult, (*m\v[2]\f[0] - *m\v[0]\f[2]) * mult, (*m\v[0]\f[1] - *m\v[1]\f[0]) * mult)
      ProcedureReturn
    Case 1
      set_float(*res, (*m\v[1]\f[2] - *m\v[2]\f[1]) * mult, biggestVal, (*m\v[0]\f[1] + *m\v[1]\f[0]) * mult, (*m\v[2]\f[0] + *m\v[0]\f[2]) * mult)
      ProcedureReturn
    Case 2
      set_float(*res, (*m\v[2]\f[0] - *m\v[0]\f[2]) * mult, (*m\v[0]\f[1] + *m\v[1]\f[0]) * mult, biggestVal, (*m\v[1]\f[2] + *m\v[2]\f[1]) * mult)
      ProcedureReturn
    Case 3:
      set_float(*res, (*m\v[0]\f[1] - *m\v[1]\f[0]) * mult, (*m\v[2]\f[0] + *m\v[0]\f[2]) * mult, (*m\v[1]\f[2] + *m\v[2]\f[1]) * mult, biggestVal)
      ProcedureReturn
    Default ; Silence a -Wswitch-Default warning in GCC. Should never actually get here. Assert is just For sanity.
      _math::assert(#False)
      set_float(*res, 1, 0, 0, 0)
      ProcedureReturn
  EndSelect
EndProcedure
Procedure quat_set_mat4x4(*res.quat, *m.mat4x4)
_math::assert(*res <> #Null And *m <> #Null)
  Protected.mat3x3 x
  set(x, *m)
  quat_set_mat3x3(*res, x)
EndProcedure
Procedure mat3x3_set_quat(*res.mat3x3, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  Protected.f qxx = *q\x * *q\x
  Protected.f qyy = *q\y * *q\y
  Protected.f qzz = *q\z * *q\z
  Protected.f qxz = *q\x * *q\z
  Protected.f qxy = *q\x * *q\y
  Protected.f qyz = *q\y * *q\z
  Protected.f qwx = *q\w * *q\x
  Protected.f qwy = *q\w * *q\y
  Protected.f qwz = *q\w * *q\z
  *res\v[0]\f[0] = 1 - 2 * (qyy + qzz)
  *res\v[0]\f[1] =     2 * (qxy + qwz)
  *res\v[0]\f[2] =     2 * (qxz - qwy)
  *res\v[1]\f[0] =     2 * (qxy - qwz)
  *res\v[1]\f[1] = 1 - 2 * (qxx + qzz)
  *res\v[1]\f[2] =     2 * (qyz + qwx)
  *res\v[2]\f[0] =     2 * (qxz + qwy)
  *res\v[2]\f[1] =     2 * (qyz - qwx)
  *res\v[2]\f[2] = 1 - 2 * (qxx + qyy)
EndProcedure
Procedure mat4x4_set_quat(*res.mat4x4, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  Protected.mat3x3 m
  mat3x3_set_quat(m, *q)
  set(*res, m)
EndProcedure
Procedure quat_mul(*res.quat, *q.quat, *p.quat)
_math::assert(*res <> #Null And *q <> #Null And *p <> #Null)
  If *res=*q
    Protected.quat tmp
    set(tmp, *q)
    *q=@tmp
  EndIf
  *res\w = *p\w * *q\w - *p\x * *q\x - *p\y * *q\y - *p\z * *q\z;
	*res\x = *p\w * *q\x + *p\x * *q\w + *p\y * *q\z - *p\z * *q\y;
	*res\y = *p\w * *q\y + *p\y * *q\w + *p\z * *q\x - *p\x * *q\z;
	*res\z = *p\w * *q\z + *p\z * *q\w + *p\x * *q\y - *p\y * *q\x;
EndProcedure
Procedure quat_mul_vec3(*res.vec3, *q.quat, *v.vec3)
_math::assert(*res <> #Null And *q <> #Null And *v <> #Null)
  Protected.vec3 quatVector, uv, uuv
  set_float(quatVector, *q\x, *q\y, *q\z)
  cross(uv, quatVector, *v)
  cross(uuv, quatVector, uv)
  ;return v + ((uv * q.w) + uuv) * static_cast<T>(2);
  let_Scalar(uv, uv, *, *q\w)
  add(uv, uv, uuv)
  let_Scalar(uv, uv, *, 2)
  add(*res, *v, uv)
EndProcedure
Procedure vec3_mul_quat(*res.vec3, *v.vec3, *q.quat)
_math::assert(*res <> #Null And *v <> #Null And *q <> #Null)
  Protected.quat inv
  quat_inverse(inv, *q)
  quat_mul_vec3(*res, inv, *v)
EndProcedure
Procedure quat_mul_vec4(*res.vec4, *q.quat, *v.vec4)
_math::assert(*res <> #Null And *q <> #Null And *v <> #Null)
  Protected.vec3 v
  set(v, *v)
  quat_mul_vec3(v, *q, v)
  vec4_set_vec3_f(*res, v, *v\w)
EndProcedure
Procedure vec4_mul_quat(*res.vec4, *v.vec4, *q.quat)
_math::assert(*res <> #Null And *v <> #Null And *q <> #Null)
  Protected.quat inv
  quat_inverse(inv, *q)
  quat_mul_vec4(*res, inv, *v)
EndProcedure
;}
;-----------------------
;- quaternion_common_inl.pbi
;{

Procedure quat_mix(*res.quat, *x.quat, *y.quat, a.f)
_math::assert(*res <> #Null And *x <> #Null And *y <> #Null)
  Protected.f cosTheta = dot(*x, *y)
  ; Perform a linear interpolation when cosTheta is close To 1 To avoid side effect of Sin(angle) becoming a zero denominator
  If (cosTheta > 1 - #epsilon)
    ;Linear interpolation
    set_float(*res,			
              mix_f(*x\w, *y\w, a),
              mix_f(*x\x, *y\x, a),
              mix_f(*x\y, *y\y, a),
              mix_f(*x\z, *y\z, a))
    ProcedureReturn		
  Else
    ; Essential Mathematics, page 467
    Protected.f angle = _math_::ACos(cosTheta)
    Protected.quat tmp
    ;Return (Sin((static_cast<T>(1) - a) * angle) * x + Sin(a * angle) * y) / Sin(angle);    
    Protected.f s 
    s = _math_::Sin((1 - a) * angle)
    Scalar_let(tmp, s, *, *x)
    s = _math_::Sin(a*angle)
    scalar_let(*res, s, * ,*y)
    add(*res, tmp, *res)
    s = _math_::Sin(angle)
    let_scalar(*res, *res, /, s)
    ProcedureReturn
  EndIf
EndProcedure
Procedure lerp(*res.quat, *x.quat, *y.quat, a.f)
_math::assert(*res <> #Null And *x <> #Null And *y <> #Null)
  ; Lerp is only defined in [0, 1]
  _math::assert(a >= 0 And a <= 1)
  Protected.quat tmp
  Scalar_let(tmp, 1-a, *, *x)
  scalar_let(*res, a, * ,*y)
  add(*res, tmp, *res)
EndProcedure
Procedure slerp(*res.quat, *x.quat, *y.quat, a.f, k.f = 0)
_math::assert(*res <> #Null And *x <> #Null And *y <> #Null)
  Protected.quat z
  Protected.f cosTheta = dot(*x, *y)
  ; If cosTheta < 0, the interpolation will take the long way around the sphere.
  ; To fix this, one quat must be negated.
  If cosTheta < 0
    scalar_let(z, 0,-,*y)
    cosTheta = -cosTheta
  Else
    set(z, *y)
  EndIf
  ; Perform a linear interpolation when cosTheta is close To 1 To avoid side effect of Sin(angle) becoming a zero denominator
  If cosTheta > 1 - #epsilon
    ; Linear interpolation
    set_float(*res,
              mix_f(*x\w, z\w, a),
              mix_f(*x\x, z\x, a),
              mix_f(*x\y, z\y, a),
              mix_f(*x\z, z\z, a))
    ProcedureReturn
  Else
    ; Essential Mathematics, page 467
    Protected.f angle = _math_::ACos(cosTheta)
    Protected.f phi = angle + k * #PI
    Protected.quat tmp
    ;Return (Sin((static_cast<T>(1) - a) * angle) * x + Sin(a * angle) * y) / Sin(angle);    
    Protected.f s 
    s = _math_::Sin(angle - a * phi)
    Scalar_let(tmp, s, *, *x)
    s = _math_::Sin(a*phi)
    scalar_let(*res, s, * ,z)
    add(*res, tmp, *res)
    s = _math_::Sin(angle)
    let_scalar(*res, *res, /, s)
    ProcedureReturn
  EndIf
EndProcedure
Procedure quat_inverse(*res.quat, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  Protected.f dot = dot(*q, *q)
  conjugate(*q, *q)
  let_Scalar(*res, *q, /, dot)
EndProcedure
;}
;-----------------------
;- quaternion_geometric_inl.pbi
;{

Procedure quat_normalize(*res.quat, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  Protected.f len = length(*q)
  If len <= 0
    set_float(*res, 1,0,0,0)
    ProcedureReturn 
  EndIf
  Protected.f oneOverLen = 1 / len
  set_float(*res, *q\w * oneOverLen, *q\x * oneOverLen, *q\y * oneOverLen, *q\z * oneOverLen)
EndProcedure
Procedure quat_cross(*res.quat, *q1.quat, *q2.quat)
_math::assert(*res <> #Null And *q1 <> #Null And *q2 <> #Null)
  Protected.quat tmp
  If *q1=*res And *q1=*res
    set(tmp, *q1)
    *q1= @tmp
    *q2= @tmp
  ElseIf *q1=*res
    set(tmp, *q1)
    *q1= @tmp
  ElseIf *q2=*res
    set(tmp, *q2)
    *q2= @tmp
  EndIf
  set_float(*res,
            *q1\w * *q2\w - *q1\x * *q2\x - *q1\y * *q2\y - *q1\z * *q2\z,
            *q1\w * *q2\x + *q1\x * *q2\w + *q1\y * *q2\z - *q1\z * *q2\y,
            *q1\w * *q2\y + *q1\y * *q2\w + *q1\z * *q2\x - *q1\x * *q2\z,
            *q1\w * *q2\z + *q1\z * *q2\w + *q1\x * *q2\y - *q1\y * *q2\x)
EndProcedure
;}
;-----------------------
;- quaternion_exponential_inl.pbi
;{

Procedure quat_exp(*res.quat, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  Protected.vec3 u,v
  set_float(u, *q\x, *q\y, *q\z)
  Protected.f angle = Length(u)
  If angle < #epsilon
    quat_set(*res)
    ProcedureReturn
  EndIf
  let_Scalar(v, u, /, angle)
  Protected.f s = _math_::Sin(angle)
  scalar_let(v, s, *, v)
  quat_set_f_vec3(*res, _math_::Cos(angle), v)
EndProcedure
Procedure quat_Log(*res.quat, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  Protected.vec3 u
  set_float(u, *q\x, *q\y, *q\z)
  Protected.f Vec3Len = length(u)
  If Vec3Len < #epsilon
    If *q\w > 0
      set_float(*res, _math_::Log(*q\w), 0, 0, 0)
      ProcedureReturn
    ElseIf *q\w < 0
      set_float(*res, _math_::Log(-*q\w), #PI, 0, 0)
      ProcedureReturn
    Else
      set_float(*res, Infinity(), Infinity(), Infinity(), Infinity())
      ProcedureReturn
    EndIf
  Else
    Protected.f t = _math_::ATan2(Vec3Len, *q\w) / Vec3Len
    Protected.f QuatLen2 = Vec3Len * Vec3Len + *q\w * *q\w
    set_float(*res, 0.5 * _math_::Log(QuatLen2), t * *q\x, t * *q\y, t * *q\z)
    ProcedureReturn
  EndIf
EndProcedure
Procedure quat_pow(*res.quat, *x.quat, y.f)
_math::assert(*res <> #Null And *x <> #Null)
  If y > -#epsilon And y < -#epsilon  
    ;Raising To the power of 0 should yield 1
    ;Needed To prevent a division by 0 error later on
    set_float(*res, 1,0,0,0)
    ProcedureReturn
  EndIf
  ;To deal With non-unit quaternions
  Protected.f magnitude = Sqr( *x\x * *x\x + *x\y * *x\y + *x\z * *x\z + *x\w * *x\w )
  Protected.f Angle;
  If _math_::Abs(*x\w / magnitude) > #cos_one_over_two
    ;Scalar component is close To 1; using it to recover angle would lose precision
    ;Instead, we use the non-scalar components since Sin() is accurate around 0
    ;Prevent a division by 0 error later on
    Protected.f VectorMagnitude = *x\x * *x\x + *x\y * *x\y + *x\z * *x\z
    ;Despite the compiler might say, we actually want To compare
    ;VectorMagnitude To 0. here; we could use denorm_int() compiling a
    ;project With unsafe maths optimizations might make the comparison
    ;always false, even when VectorMagnitude is 0.
    If VectorMagnitude < #flt_min
      ;Equivalent To raising a real number To a power
      set_float(*res, _math_::Pow(*x\w, y), 0,0,0)
      ProcedureReturn
    EndIf
    Angle = _math_::ASin( Sqr(VectorMagnitude) / magnitude)
  Else
    ;Scalar component is small, shouldn't cause loss of precision
    Angle = _math_::ACos( *x\w / magnitude)
  EndIf
  Protected.f NewAngle = Angle * y
  Protected.f Div = _math_::Sin(NewAngle) / _math_::Sin(Angle)
  Protected.f Mag = _math_::Pow(magnitude, y - 1)
  set_float(*res, _math_::Cos(NewAngle) * magnitude * Mag, *x\x * Div * Mag, *x\y * Div * Mag, *x\z * Div * Mag)
EndProcedure
Procedure quat_sqrt(*res.quat, *q.quat)
_math::assert(*res <> #Null And *q <> #Null)
  quat_pow(*res, *q, 0.5)
EndProcedure
;}
;-----------------------
;- quaternion_transform_inl.pbi
;{

Procedure quat_rotate(*res.quat, *q.quat, angle.f, *v.vec3)
_math::assert(*res <> #Null And *q <> #Null And *v <> #Null)
  Protected.vec3 Tmp 
  set(tmp, *v)
  ; Axis of rotation must be normalised
  Protected.f len = length(Tmp)
  If _math_::Abs(len - 1) > 0.001
    Protected.f oneOverLen = 1 / len;
    Tmp\x * oneOverLen
    Tmp\y * oneOverLen
    Tmp\z * oneOverLen
  EndIf
  Protected.f AngleRad=angle
  Protected.f Sin = _math_::Sin(AngleRad * 0.5)
  ;Return q * qua<T, Q>(Cos(AngleRad * static_cast<T>(0.5)), Tmp.x * Sin, Tmp.y * Sin, Tmp.z * Sin);
  Protected.quat tmpq
  set_float(tmpq, _math_::Cos(AngleRad * 0.5), Tmp\x * Sin, Tmp\y * Sin, Tmp\z * Sin)
  mul(*res, *q, tmpq)
EndProcedure
;}
;-----------------------
;- quaternion_trigonometric_inl.pbi
;{

Procedure.f angle(*x.quat)
_math::assert(*x <> #Null)
  If _math_::Abs(*x\w) > #cos_one_over_two
    Protected.f a = _math_::ASin(Sqr(*x\x * *x\x + *x\y * *x\y + *x\z * *x\z)) * 2
    If *x\w < 0
      ProcedureReturn #PI * 2 - a
    EndIf
    ProcedureReturn a
  EndIf
  ProcedureReturn _math_::ACos(*x\w) * 2
EndProcedure
Procedure axis(*res.vec3, *x.quat)
_math::assert(*res <> #Null And *x <> #Null)
  Protected.f  tmp1 = 1 - *x\w * *x\w
  If tmp1 <= 0
    set_float(*res,0,0,1)
    ProcedureReturn
  EndIf
  Protected.f tmp2 = 1 / Sqr(tmp1)
  set_float(*res, *x\x * tmp2, *x\y * tmp2, *x\z * tmp2)
EndProcedure
Procedure angleAxis(*res.quat, angle.f, *v.vec3)
_math::assert(*res <> #Null And *v <> #Null)
  Protected.f s = _math_::Sin(angle * 0.5)
  Protected.vec3 v
  let_Scalar(v, *v, *, s)
  quat_set_f_vec3(*res,_math_::Cos(angle * 0.5), v )
EndProcedure
;}
;-----------------------
;- scalar_reciprocal_inl.pbi
;{

	; sec
	Procedure.f sec_f(angle.f)
	  ProcedureReturn 1 / _math_::Cos(angle)
	EndProcedure
	; csc
	Procedure.f csc_f(angle.f)
	  ProcedureReturn 1 / _math_::Sin(angle)
	EndProcedure
	; cot
	Procedure.f cot_f(angle.f)
		ProcedureReturn _math_::Tan(#PI/2 - angle)
	EndProcedure
	; asec
	Procedure.f asec_f(x.f)
	  ProcedureReturn _math_::ACos(1 / x)
	EndProcedure
	; acsc
	Procedure.f acsc_f(x.f)
		ProcedureReturn _math_::ASin(1 / x)
	EndProcedure
	; acot
	Procedure.f acot_f(x.f)
	  ProcedureReturn #PI/2 - _math_::ATan(x)
	EndProcedure
	; sech
	Procedure.f sech_f(angle.f)
	  ProcedureReturn 1 / _math_::CosH(angle)
	EndProcedure
	; csch
	Procedure.f csch_f(angle.f)
	  ProcedureReturn 1 / _math_::SinH(angle)
	EndProcedure
	; coth
	Procedure.f coth_f(angle.f)
	  ProcedureReturn _math_::CosH(angle) / _math_::SinH(angle)
	EndProcedure
	; asech
	Procedure.f asech_f(x.f)
	  ProcedureReturn _math_::ACosH(1 / x)
	EndProcedure
	; acsch
	Procedure.f acsch_f(x.f)
	  ProcedureReturn _math_::ASinH(1 / x)
	EndProcedure
	; acoth
	Procedure.f acoth_f(x.f)
	  ProcedureReturn _math_::ATanH(1 / x)
	EndProcedure
	
;}
;-----------------------
;- quatemion_inl.pbi
;{

Procedure eulerAngles(*res.vec3, *x.quat)
_math::assert(*res <> #Null And *x <> #Null)
	math::set_float(*res, math::Pitch(*x), math::Yaw(*x), math::Roll(*x))
EndProcedure
Procedure quat_LookAt(*res.quat, *direction.vec3, *up.vec3)
_math::assert(*res <> #Null And *direction <> #Null And *up <> #Null)
	ProcedureReturn quat_LookAtRH(*res, *direction, *up)
EndProcedure
Procedure quat_LookAtRH(*res.quat, *direction.vec3, *up.vec3)
_math::assert(*res <> #Null And *direction <> #Null And *up <> #Null)
  Protected.mat3x3 result
  Protected.vec3 right
  mat3x3_set(result)
  Scalar_let_vec3( Result\v[2], 0, -, *direction)
  Vec3_Cross(right, *up, result\v[2])
  Protected.f s = inversesqrt_f(max_f(0.00001, dot(Right, Right)))
  vec3_let_Scalar( Result\v[0], right, *, s)
  Vec3_Cross(result\v[1], result\v[2], result\v[0])
  set(*res, Result)
EndProcedure
Procedure quat_LookAtLH(*res.quat, *direction.vec3, *up.vec3)
_math::assert(*res <> #Null And *direction <> #Null And *up <> #Null)
	Protected.mat3x3 result
  Protected.vec3 right
  mat3x3_set(result)
  vec3_set_vec3( Result\v[2], *direction)
  Vec3_Cross(right, *up, result\v[2])
	Protected.f s = inversesqrt_f(max_f(0.00001, dot(Right, Right)))
  vec3_let_Scalar( Result\v[0], right, *, s)
	Vec3_Cross(result\v[1], result\v[2], result\v[0])
	set(*res, Result)
EndProcedure
;}
EndModule
