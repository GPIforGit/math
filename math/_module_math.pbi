Module math
  set_float(v4_0000,0,0,0,0)
  set_float(v4_0001,0,0,0,1)
  set_float(v4_0010,0,0,1,0)
  set_float(v4_0011,0,0,1,1)
  set_float(v4_0100,0,1,0,0)
  set_float(v4_0101,0,1,0,1)
  set_float(v4_0110,0,1,1,0)
  set_float(v4_0111,0,1,1,1)
  set_float(v4_1000,1,0,0,0)
  set_float(v4_1001,1,0,0,1)
  set_float(v4_1010,1,0,1,0)
  set_float(v4_1011,1,0,1,1)
  set_float(v4_1100,1,1,0,0)
  set_float(v4_1101,1,1,0,1)
  set_float(v4_1110,1,1,1,0)
  set_float(v4_1111,1,1,1,1)
  set_float(v3_000,0,0,0)
  set_float(v3_001,0,0,1)
  set_float(v3_010,0,1,0)
  set_float(v3_011,0,1,1)
  set_float(v3_100,1,0,0)
  set_float(v3_101,1,0,1)
  set_float(v3_110,1,1,0)
  set_float(v3_111,1,1,1)
  set_float(v2_00,0,0)
  set_float(v2_01,0,1)
  set_float(v2_10,1,0)
  set_float(v2_11,1,1)
  set_float(m4_1,1)
  set_float(m3_1,1)
  set_float(m2_1,1)
  set_float(q_1,1,0,0,0)
  one = 1.0
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
  ProcedureReturn one / Sqr(f)
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

UseModule math
Procedure Vec3_Cross(*res.vec3, *x.Vec3, *y.vec3)
_math::assert(*res <> #Null And *x <> #Null And *y <> #Null)
  If *res = *x
    Protected.vec3 tmp
    vec3_set(tmp,*x)
    *x=@tmp
  EndIf  
  vec3_set_float(*res,
                 (*x\y * *y\z - *y\y * *x\z),
                 (*x\z * *y\x - *y\z * *x\x),
                 (*x\x * *y\y - *y\x * *x\y))
  ProcedureReturn *res
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

;-Mat2x2
Procedure Mat2x2_set_float(*res.Mat2x2, x0.f, y0.f, x1.f, y1.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_vec2(*res.Mat2x2, *v0.vec2, *v1.vec2)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set(*res.Mat2x2, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat2x3(*res.Mat2x2, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat2x4(*res.Mat2x2, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat3x2(*res.Mat2x2, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat3x3(*res.Mat2x2, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat3x4(*res.Mat2x2, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat4x2(*res.Mat2x2, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat4x3(*res.Mat2x2, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Mat4x4(*res.Mat2x2, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_set_Scalar(*res.Mat2x2, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_add_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_sub_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_mul_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_div_Scalar(*res.Mat2x2, *m.Mat2x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat2x2(*res.Mat2x2, s.f, *m.Mat2x2)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_add(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_sub(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_mul(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
 Protected.Mat2x2 tmp
If *res = *m1 And *res = *m2
  Mat2x2_set(tmp, *m1)
  *m1=@tmp
  *m2=@tmp
ElseIf *res=*m1
  Mat2x2_set(tmp, *m1)
  *m1=@tmp
ElseIf *res=*m2
  Mat2x2_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_mul_Mat3x2(*res.Mat3x2, *m1.Mat2x2, *m2.Mat3x2)
 Protected.Mat3x2 tmp
If *res=*m2
  Mat3x2_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_mul_Mat4x2(*res.Mat4x2, *m1.Mat2x2, *m2.Mat4x2)
 Protected.Mat4x2 tmp
If *res=*m2
  Mat4x2_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_div(*res.Mat2x2, *m1.Mat2x2, *m2.Mat2x2)
  Protected.Mat2x2 tmp
  Mat2x2_inverse(tmp, *m2)
  Mat2x2_mul(*res, *m1, tmp)
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_div_vec2(*res.Mat2x2, *m.Mat2x2, *v.vec2)
  Protected.Mat2x2 tmp
  Mat2x2_inverse(tmp, *m)
  Mat2x2_mul_vec2(*res, tmp, *v)
  ProcedureReturn *res
EndProcedure
Procedure vec2_div_Mat2x2(*res.Mat2x2, *v.vec2, *m.Mat2x2 )
  Protected.Mat2x2 tmp
  Mat2x2_inverse(tmp, *m)
  vec2_mul_Mat2x2(*res, *v, tmp)
  ProcedureReturn *res
EndProcedure
Procedure Mat2x2_mul_Vec2(*vecres.Vec2, *m.Mat2x2, *v.Vec2)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y
  ProcedureReturn *vecres
EndProcedure
Procedure Vec2_mul_Mat2x2(*vecres.Vec2, *v.Vec2, *m.Mat2x2)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1]
  ProcedureReturn *vecres
EndProcedure
;-Mat2x3
Procedure Mat2x3_set_float(*res.Mat2x3, x0.f, y0.f, z0.f, x1.f, y1.f, z1.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[0]\f[2] = z0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[1]\f[2] = z1
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_vec3(*res.Mat2x3, *v0.vec3, *v1.vec3)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[0]\f[2] = *v0\z
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[1]\f[2] = *v1\z
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat2x2(*res.Mat2x3, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set(*res.Mat2x3, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat2x4(*res.Mat2x3, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat3x2(*res.Mat2x3, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat3x3(*res.Mat2x3, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat3x4(*res.Mat2x3, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat4x2(*res.Mat2x3, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat4x3(*res.Mat2x3, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Mat4x4(*res.Mat2x3, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_set_Scalar(*res.Mat2x3, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[1]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_add_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[0]\f[2] = *m\v[0]\f[2] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[1]\f[2] = *m\v[1]\f[2] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_sub_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[0]\f[2] = *m\v[0]\f[2] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[1]\f[2] = *m\v[1]\f[2] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_mul_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[0]\f[2] = *m\v[0]\f[2] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[1]\f[2] = *m\v[1]\f[2] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_div_Scalar(*res.Mat2x3, *m.Mat2x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[0]\f[2] = *m\v[0]\f[2] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[1]\f[2] = *m\v[1]\f[2] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[0]\f[2] = s + *m\v[0]\f[2]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[1]\f[2] = s + *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[0]\f[2] = s - *m\v[0]\f[2]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[1]\f[2] = s - *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[0]\f[2] = s * *m\v[0]\f[2]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[1]\f[2] = s * *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat2x3(*res.Mat2x3, s.f, *m.Mat2x3)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[0]\f[2] = s / *m\v[0]\f[2]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[1]\f[2] = s / *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_add(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] + *m2\v[0]\f[2]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] + *m2\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_sub(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] - *m2\v[0]\f[2]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] - *m2\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_mul_Mat2x2(*res.Mat2x3, *m1.Mat2x3, *m2.Mat2x2)
 Protected.Mat2x3 tmp
If *res=*m1
  Mat2x3_set(tmp, *m1)
  *m1=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_mul_Mat3x2(*res.Mat3x3, *m1.Mat2x3, *m2.Mat3x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_mul_Mat4x2(*res.Mat4x3, *m1.Mat2x3, *m2.Mat4x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1]
  *res\v[3]\f[2] = *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x3_mul_Vec2(*vecres.Vec3, *m.Mat2x3, *v.Vec2)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y
*vecres\z = *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y
  ProcedureReturn *vecres
EndProcedure
Procedure Vec3_mul_Mat2x3(*vecres.Vec2, *v.Vec3, *m.Mat2x3)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2]
  ProcedureReturn *vecres
EndProcedure
;-Mat2x4
Procedure Mat2x4_set_float(*res.Mat2x4, x0.f, y0.f, z0.f, w0.f, x1.f, y1.f, z1.f, w1.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[0]\f[2] = z0
  *res\v[0]\f[3] = w0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[1]\f[2] = z1
  *res\v[1]\f[3] = w1
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_vec4(*res.Mat2x4, *v0.vec4, *v1.vec4)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[0]\f[2] = *v0\z
  *res\v[0]\f[3] = *v0\w
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[1]\f[2] = *v1\z
  *res\v[1]\f[3] = *v1\w
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat2x2(*res.Mat2x4, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat2x3(*res.Mat2x4, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set(*res.Mat2x4, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat3x2(*res.Mat2x4, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat3x3(*res.Mat2x4, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat3x4(*res.Mat2x4, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat4x2(*res.Mat2x4, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat4x3(*res.Mat2x4, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Mat4x4(*res.Mat2x4, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_set_Scalar(*res.Mat2x4, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_add_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[0]\f[2] = *m\v[0]\f[2] + s
  *res\v[0]\f[3] = *m\v[0]\f[3] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[1]\f[2] = *m\v[1]\f[2] + s
  *res\v[1]\f[3] = *m\v[1]\f[3] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_sub_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[0]\f[2] = *m\v[0]\f[2] - s
  *res\v[0]\f[3] = *m\v[0]\f[3] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[1]\f[2] = *m\v[1]\f[2] - s
  *res\v[1]\f[3] = *m\v[1]\f[3] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_mul_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[0]\f[2] = *m\v[0]\f[2] * s
  *res\v[0]\f[3] = *m\v[0]\f[3] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[1]\f[2] = *m\v[1]\f[2] * s
  *res\v[1]\f[3] = *m\v[1]\f[3] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_div_Scalar(*res.Mat2x4, *m.Mat2x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[0]\f[2] = *m\v[0]\f[2] / s
  *res\v[0]\f[3] = *m\v[0]\f[3] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[1]\f[2] = *m\v[1]\f[2] / s
  *res\v[1]\f[3] = *m\v[1]\f[3] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[0]\f[2] = s + *m\v[0]\f[2]
  *res\v[0]\f[3] = s + *m\v[0]\f[3]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[1]\f[2] = s + *m\v[1]\f[2]
  *res\v[1]\f[3] = s + *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[0]\f[2] = s - *m\v[0]\f[2]
  *res\v[0]\f[3] = s - *m\v[0]\f[3]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[1]\f[2] = s - *m\v[1]\f[2]
  *res\v[1]\f[3] = s - *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[0]\f[2] = s * *m\v[0]\f[2]
  *res\v[0]\f[3] = s * *m\v[0]\f[3]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[1]\f[2] = s * *m\v[1]\f[2]
  *res\v[1]\f[3] = s * *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat2x4(*res.Mat2x4, s.f, *m.Mat2x4)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[0]\f[2] = s / *m\v[0]\f[2]
  *res\v[0]\f[3] = s / *m\v[0]\f[3]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[1]\f[2] = s / *m\v[1]\f[2]
  *res\v[1]\f[3] = s / *m\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_add(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] + *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] + *m2\v[0]\f[3]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] + *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[1]\f[3] + *m2\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_sub(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] - *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] - *m2\v[0]\f[3]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] - *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[1]\f[3] - *m2\v[1]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_mul_Mat2x2(*res.Mat2x4, *m1.Mat2x4, *m2.Mat2x2)
 Protected.Mat2x4 tmp
If *res=*m1
  Mat2x4_set(tmp, *m1)
  *m1=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_mul_Mat3x2(*res.Mat3x4, *m1.Mat2x4, *m2.Mat3x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1]
  *res\v[2]\f[3] = *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_mul_Mat4x2(*res.Mat4x4, *m1.Mat2x4, *m2.Mat4x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1]
  *res\v[2]\f[3] = *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1]
  *res\v[3]\f[2] = *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1]
  *res\v[3]\f[3] = *m1\v[0]\f[3] * *m2\v[3]\f[0] + *m1\v[1]\f[3] * *m2\v[3]\f[1]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat2x4_mul_Vec2(*vecres.Vec4, *m.Mat2x4, *v.Vec2)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y
*vecres\z = *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y
*vecres\w = *m\v[0]\f[3] * *v\x + *m\v[1]\f[3] * *v\y
  ProcedureReturn *vecres
EndProcedure
Procedure Vec4_mul_Mat2x4(*vecres.Vec2, *v.Vec4, *m.Mat2x4)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2] + *v\w * *m\v[0]\f[3]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2] + *v\w * *m\v[1]\f[3]
  ProcedureReturn *vecres
EndProcedure
;-Mat3x2
Procedure Mat3x2_set_float(*res.Mat3x2, x0.f, y0.f, x1.f, y1.f, x2.f, y2.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[2]\f[0] = x2
  *res\v[2]\f[1] = y2
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_vec2(*res.Mat3x2, *v0.vec2, *v1.vec2, *v2.vec2)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[2]\f[0] = *v2\x
  *res\v[2]\f[1] = *v2\y
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat2x2(*res.Mat3x2, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat2x3(*res.Mat3x2, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat2x4(*res.Mat3x2, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set(*res.Mat3x2, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat3x3(*res.Mat3x2, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat3x4(*res.Mat3x2, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat4x2(*res.Mat3x2, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat4x3(*res.Mat3x2, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Mat4x4(*res.Mat3x2, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_set_Scalar(*res.Mat3x2, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_add_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[2]\f[0] = *m\v[2]\f[0] + s
  *res\v[2]\f[1] = *m\v[2]\f[1] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_sub_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[2]\f[0] = *m\v[2]\f[0] - s
  *res\v[2]\f[1] = *m\v[2]\f[1] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_mul_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[2]\f[0] = *m\v[2]\f[0] * s
  *res\v[2]\f[1] = *m\v[2]\f[1] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_div_Scalar(*res.Mat3x2, *m.Mat3x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[2]\f[0] = *m\v[2]\f[0] / s
  *res\v[2]\f[1] = *m\v[2]\f[1] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[2]\f[0] = s + *m\v[2]\f[0]
  *res\v[2]\f[1] = s + *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[2]\f[0] = s - *m\v[2]\f[0]
  *res\v[2]\f[1] = s - *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[2]\f[0] = s * *m\v[2]\f[0]
  *res\v[2]\f[1] = s * *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat3x2(*res.Mat3x2, s.f, *m.Mat3x2)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[2]\f[0] = s / *m\v[2]\f[0]
  *res\v[2]\f[1] = s / *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_add(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[2]\f[0] = *m1\v[2]\f[0] + *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] + *m2\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_sub(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[2]\f[0] = *m1\v[2]\f[0] - *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] - *m2\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_mul_Mat2x3(*res.Mat2x2, *m1.Mat3x2, *m2.Mat2x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_mul_Mat3x3(*res.Mat3x2, *m1.Mat3x2, *m2.Mat3x3)
 Protected.Mat3x2 tmp
If *res=*m1
  Mat3x2_set(tmp, *m1)
  *m1=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_mul_Mat4x3(*res.Mat4x2, *m1.Mat3x2, *m2.Mat4x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x2_mul_Vec3(*vecres.Vec2, *m.Mat3x2, *v.Vec3)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z
  ProcedureReturn *vecres
EndProcedure
Procedure Vec2_mul_Mat3x2(*vecres.Vec3, *v.Vec2, *m.Mat3x2)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1]
*vecres\z = *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1]
  ProcedureReturn *vecres
EndProcedure
;-Mat3x3
Procedure Mat3x3_set_float(*res.Mat3x3, x0.f, y0.f, z0.f, x1.f, y1.f, z1.f, x2.f, y2.f, z2.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[0]\f[2] = z0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[1]\f[2] = z1
  *res\v[2]\f[0] = x2
  *res\v[2]\f[1] = y2
  *res\v[2]\f[2] = z2
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_vec3(*res.Mat3x3, *v0.vec3, *v1.vec3, *v2.vec3)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[0]\f[2] = *v0\z
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[1]\f[2] = *v1\z
  *res\v[2]\f[0] = *v2\x
  *res\v[2]\f[1] = *v2\y
  *res\v[2]\f[2] = *v2\z
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat2x2(*res.Mat3x3, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat2x3(*res.Mat3x3, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat2x4(*res.Mat3x3, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat3x2(*res.Mat3x3, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set(*res.Mat3x3, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat3x4(*res.Mat3x3, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat4x2(*res.Mat3x3, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat4x3(*res.Mat3x3, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Mat4x4(*res.Mat3x3, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_set_Scalar(*res.Mat3x3, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_add_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[0]\f[2] = *m\v[0]\f[2] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[1]\f[2] = *m\v[1]\f[2] + s
  *res\v[2]\f[0] = *m\v[2]\f[0] + s
  *res\v[2]\f[1] = *m\v[2]\f[1] + s
  *res\v[2]\f[2] = *m\v[2]\f[2] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_sub_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[0]\f[2] = *m\v[0]\f[2] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[1]\f[2] = *m\v[1]\f[2] - s
  *res\v[2]\f[0] = *m\v[2]\f[0] - s
  *res\v[2]\f[1] = *m\v[2]\f[1] - s
  *res\v[2]\f[2] = *m\v[2]\f[2] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_mul_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[0]\f[2] = *m\v[0]\f[2] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[1]\f[2] = *m\v[1]\f[2] * s
  *res\v[2]\f[0] = *m\v[2]\f[0] * s
  *res\v[2]\f[1] = *m\v[2]\f[1] * s
  *res\v[2]\f[2] = *m\v[2]\f[2] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_div_Scalar(*res.Mat3x3, *m.Mat3x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[0]\f[2] = *m\v[0]\f[2] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[1]\f[2] = *m\v[1]\f[2] / s
  *res\v[2]\f[0] = *m\v[2]\f[0] / s
  *res\v[2]\f[1] = *m\v[2]\f[1] / s
  *res\v[2]\f[2] = *m\v[2]\f[2] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[0]\f[2] = s + *m\v[0]\f[2]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[1]\f[2] = s + *m\v[1]\f[2]
  *res\v[2]\f[0] = s + *m\v[2]\f[0]
  *res\v[2]\f[1] = s + *m\v[2]\f[1]
  *res\v[2]\f[2] = s + *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[0]\f[2] = s - *m\v[0]\f[2]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[1]\f[2] = s - *m\v[1]\f[2]
  *res\v[2]\f[0] = s - *m\v[2]\f[0]
  *res\v[2]\f[1] = s - *m\v[2]\f[1]
  *res\v[2]\f[2] = s - *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[0]\f[2] = s * *m\v[0]\f[2]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[1]\f[2] = s * *m\v[1]\f[2]
  *res\v[2]\f[0] = s * *m\v[2]\f[0]
  *res\v[2]\f[1] = s * *m\v[2]\f[1]
  *res\v[2]\f[2] = s * *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat3x3(*res.Mat3x3, s.f, *m.Mat3x3)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[0]\f[2] = s / *m\v[0]\f[2]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[1]\f[2] = s / *m\v[1]\f[2]
  *res\v[2]\f[0] = s / *m\v[2]\f[0]
  *res\v[2]\f[1] = s / *m\v[2]\f[1]
  *res\v[2]\f[2] = s / *m\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_add(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] + *m2\v[0]\f[2]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] + *m2\v[1]\f[2]
  *res\v[2]\f[0] = *m1\v[2]\f[0] + *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] + *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] + *m2\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_sub(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] - *m2\v[0]\f[2]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] - *m2\v[1]\f[2]
  *res\v[2]\f[0] = *m1\v[2]\f[0] - *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] - *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] - *m2\v[2]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_mul_Mat2x3(*res.Mat2x3, *m1.Mat3x3, *m2.Mat2x3)
 Protected.Mat2x3 tmp
If *res=*m2
  Mat2x3_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_mul(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
 Protected.Mat3x3 tmp
If *res = *m1 And *res = *m2
  Mat3x3_set(tmp, *m1)
  *m1=@tmp
  *m2=@tmp
ElseIf *res=*m1
  Mat3x3_set(tmp, *m1)
  *m1=@tmp
ElseIf *res=*m2
  Mat3x3_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_mul_Mat4x3(*res.Mat4x3, *m1.Mat3x3, *m2.Mat4x3)
 Protected.Mat4x3 tmp
If *res=*m2
  Mat4x3_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2]
  *res\v[3]\f[2] = *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_div(*res.Mat3x3, *m1.Mat3x3, *m2.Mat3x3)
  Protected.Mat3x3 tmp
  Mat3x3_inverse(tmp, *m2)
  Mat3x3_mul(*res, *m1, tmp)
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_div_vec3(*res.Mat3x3, *m.Mat3x3, *v.vec3)
  Protected.Mat3x3 tmp
  Mat3x3_inverse(tmp, *m)
  Mat3x3_mul_vec3(*res, tmp, *v)
  ProcedureReturn *res
EndProcedure
Procedure vec3_div_Mat3x3(*res.Mat3x3, *v.vec3, *m.Mat3x3 )
  Protected.Mat3x3 tmp
  Mat3x3_inverse(tmp, *m)
  vec3_mul_Mat3x3(*res, *v, tmp)
  ProcedureReturn *res
EndProcedure
Procedure Mat3x3_mul_Vec3(*vecres.Vec3, *m.Mat3x3, *v.Vec3)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z
*vecres\z = *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z
  ProcedureReturn *vecres
EndProcedure
Procedure Vec3_mul_Mat3x3(*vecres.Vec3, *v.Vec3, *m.Mat3x3)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2]
*vecres\z = *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2]
  ProcedureReturn *vecres
EndProcedure
;-Mat3x4
Procedure Mat3x4_set_float(*res.Mat3x4, x0.f, y0.f, z0.f, w0.f, x1.f, y1.f, z1.f, w1.f, x2.f, y2.f, z2.f, w2.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[0]\f[2] = z0
  *res\v[0]\f[3] = w0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[1]\f[2] = z1
  *res\v[1]\f[3] = w1
  *res\v[2]\f[0] = x2
  *res\v[2]\f[1] = y2
  *res\v[2]\f[2] = z2
  *res\v[2]\f[3] = w2
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_vec4(*res.Mat3x4, *v0.vec4, *v1.vec4, *v2.vec4)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[0]\f[2] = *v0\z
  *res\v[0]\f[3] = *v0\w
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[1]\f[2] = *v1\z
  *res\v[1]\f[3] = *v1\w
  *res\v[2]\f[0] = *v2\x
  *res\v[2]\f[1] = *v2\y
  *res\v[2]\f[2] = *v2\z
  *res\v[2]\f[3] = *v2\w
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat2x2(*res.Mat3x4, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat2x3(*res.Mat3x4, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat2x4(*res.Mat3x4, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat3x2(*res.Mat3x4, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat3x3(*res.Mat3x4, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set(*res.Mat3x4, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = *m\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat4x2(*res.Mat3x4, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat4x3(*res.Mat3x4, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Mat4x4(*res.Mat3x4, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = *m\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_set_Scalar(*res.Mat3x4, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = s
  *res\v[2]\f[3] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_add_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[0]\f[2] = *m\v[0]\f[2] + s
  *res\v[0]\f[3] = *m\v[0]\f[3] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[1]\f[2] = *m\v[1]\f[2] + s
  *res\v[1]\f[3] = *m\v[1]\f[3] + s
  *res\v[2]\f[0] = *m\v[2]\f[0] + s
  *res\v[2]\f[1] = *m\v[2]\f[1] + s
  *res\v[2]\f[2] = *m\v[2]\f[2] + s
  *res\v[2]\f[3] = *m\v[2]\f[3] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_sub_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[0]\f[2] = *m\v[0]\f[2] - s
  *res\v[0]\f[3] = *m\v[0]\f[3] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[1]\f[2] = *m\v[1]\f[2] - s
  *res\v[1]\f[3] = *m\v[1]\f[3] - s
  *res\v[2]\f[0] = *m\v[2]\f[0] - s
  *res\v[2]\f[1] = *m\v[2]\f[1] - s
  *res\v[2]\f[2] = *m\v[2]\f[2] - s
  *res\v[2]\f[3] = *m\v[2]\f[3] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_mul_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[0]\f[2] = *m\v[0]\f[2] * s
  *res\v[0]\f[3] = *m\v[0]\f[3] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[1]\f[2] = *m\v[1]\f[2] * s
  *res\v[1]\f[3] = *m\v[1]\f[3] * s
  *res\v[2]\f[0] = *m\v[2]\f[0] * s
  *res\v[2]\f[1] = *m\v[2]\f[1] * s
  *res\v[2]\f[2] = *m\v[2]\f[2] * s
  *res\v[2]\f[3] = *m\v[2]\f[3] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_div_Scalar(*res.Mat3x4, *m.Mat3x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[0]\f[2] = *m\v[0]\f[2] / s
  *res\v[0]\f[3] = *m\v[0]\f[3] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[1]\f[2] = *m\v[1]\f[2] / s
  *res\v[1]\f[3] = *m\v[1]\f[3] / s
  *res\v[2]\f[0] = *m\v[2]\f[0] / s
  *res\v[2]\f[1] = *m\v[2]\f[1] / s
  *res\v[2]\f[2] = *m\v[2]\f[2] / s
  *res\v[2]\f[3] = *m\v[2]\f[3] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[0]\f[2] = s + *m\v[0]\f[2]
  *res\v[0]\f[3] = s + *m\v[0]\f[3]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[1]\f[2] = s + *m\v[1]\f[2]
  *res\v[1]\f[3] = s + *m\v[1]\f[3]
  *res\v[2]\f[0] = s + *m\v[2]\f[0]
  *res\v[2]\f[1] = s + *m\v[2]\f[1]
  *res\v[2]\f[2] = s + *m\v[2]\f[2]
  *res\v[2]\f[3] = s + *m\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[0]\f[2] = s - *m\v[0]\f[2]
  *res\v[0]\f[3] = s - *m\v[0]\f[3]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[1]\f[2] = s - *m\v[1]\f[2]
  *res\v[1]\f[3] = s - *m\v[1]\f[3]
  *res\v[2]\f[0] = s - *m\v[2]\f[0]
  *res\v[2]\f[1] = s - *m\v[2]\f[1]
  *res\v[2]\f[2] = s - *m\v[2]\f[2]
  *res\v[2]\f[3] = s - *m\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[0]\f[2] = s * *m\v[0]\f[2]
  *res\v[0]\f[3] = s * *m\v[0]\f[3]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[1]\f[2] = s * *m\v[1]\f[2]
  *res\v[1]\f[3] = s * *m\v[1]\f[3]
  *res\v[2]\f[0] = s * *m\v[2]\f[0]
  *res\v[2]\f[1] = s * *m\v[2]\f[1]
  *res\v[2]\f[2] = s * *m\v[2]\f[2]
  *res\v[2]\f[3] = s * *m\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat3x4(*res.Mat3x4, s.f, *m.Mat3x4)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[0]\f[2] = s / *m\v[0]\f[2]
  *res\v[0]\f[3] = s / *m\v[0]\f[3]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[1]\f[2] = s / *m\v[1]\f[2]
  *res\v[1]\f[3] = s / *m\v[1]\f[3]
  *res\v[2]\f[0] = s / *m\v[2]\f[0]
  *res\v[2]\f[1] = s / *m\v[2]\f[1]
  *res\v[2]\f[2] = s / *m\v[2]\f[2]
  *res\v[2]\f[3] = s / *m\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_add(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] + *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] + *m2\v[0]\f[3]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] + *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[1]\f[3] + *m2\v[1]\f[3]
  *res\v[2]\f[0] = *m1\v[2]\f[0] + *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] + *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] + *m2\v[2]\f[2]
  *res\v[2]\f[3] = *m1\v[2]\f[3] + *m2\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_sub(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] - *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] - *m2\v[0]\f[3]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] - *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[1]\f[3] - *m2\v[1]\f[3]
  *res\v[2]\f[0] = *m1\v[2]\f[0] - *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] - *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] - *m2\v[2]\f[2]
  *res\v[2]\f[3] = *m1\v[2]\f[3] - *m2\v[2]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_mul_Mat2x3(*res.Mat2x4, *m1.Mat3x4, *m2.Mat2x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_mul_Mat3x3(*res.Mat3x4, *m1.Mat3x4, *m2.Mat3x3)
 Protected.Mat3x4 tmp
If *res=*m1
  Mat3x4_set(tmp, *m1)
  *m1=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2]
  *res\v[2]\f[3] = *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_mul_Mat4x3(*res.Mat4x4, *m1.Mat3x4, *m2.Mat4x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2]
  *res\v[2]\f[3] = *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2]
  *res\v[3]\f[2] = *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2]
  *res\v[3]\f[3] = *m1\v[0]\f[3] * *m2\v[3]\f[0] + *m1\v[1]\f[3] * *m2\v[3]\f[1] + *m1\v[2]\f[3] * *m2\v[3]\f[2]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat3x4_mul_Vec3(*vecres.Vec4, *m.Mat3x4, *v.Vec3)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z
*vecres\z = *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z
*vecres\w = *m\v[0]\f[3] * *v\x + *m\v[1]\f[3] * *v\y + *m\v[2]\f[3] * *v\z
  ProcedureReturn *vecres
EndProcedure
Procedure Vec4_mul_Mat3x4(*vecres.Vec3, *v.Vec4, *m.Mat3x4)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2] + *v\w * *m\v[0]\f[3]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2] + *v\w * *m\v[1]\f[3]
*vecres\z = *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2] + *v\w * *m\v[2]\f[3]
  ProcedureReturn *vecres
EndProcedure
;-Mat4x2
Procedure Mat4x2_set_float(*res.Mat4x2, x0.f, y0.f, x1.f, y1.f, x2.f, y2.f, x3.f, y3.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[2]\f[0] = x2
  *res\v[2]\f[1] = y2
  *res\v[3]\f[0] = x3
  *res\v[3]\f[1] = y3
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_vec2(*res.Mat4x2, *v0.vec2, *v1.vec2, *v2.vec2, *v3.vec2)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[2]\f[0] = *v2\x
  *res\v[2]\f[1] = *v2\y
  *res\v[3]\f[0] = *v3\x
  *res\v[3]\f[1] = *v3\y
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat2x2(*res.Mat4x2, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat2x3(*res.Mat4x2, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat2x4(*res.Mat4x2, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat3x2(*res.Mat4x2, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat3x3(*res.Mat4x2, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat3x4(*res.Mat4x2, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set(*res.Mat4x2, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat4x3(*res.Mat4x2, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Mat4x4(*res.Mat4x2, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_set_Scalar(*res.Mat4x2, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_add_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[2]\f[0] = *m\v[2]\f[0] + s
  *res\v[2]\f[1] = *m\v[2]\f[1] + s
  *res\v[3]\f[0] = *m\v[3]\f[0] + s
  *res\v[3]\f[1] = *m\v[3]\f[1] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_sub_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[2]\f[0] = *m\v[2]\f[0] - s
  *res\v[2]\f[1] = *m\v[2]\f[1] - s
  *res\v[3]\f[0] = *m\v[3]\f[0] - s
  *res\v[3]\f[1] = *m\v[3]\f[1] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_mul_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[2]\f[0] = *m\v[2]\f[0] * s
  *res\v[2]\f[1] = *m\v[2]\f[1] * s
  *res\v[3]\f[0] = *m\v[3]\f[0] * s
  *res\v[3]\f[1] = *m\v[3]\f[1] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_div_Scalar(*res.Mat4x2, *m.Mat4x2, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[2]\f[0] = *m\v[2]\f[0] / s
  *res\v[2]\f[1] = *m\v[2]\f[1] / s
  *res\v[3]\f[0] = *m\v[3]\f[0] / s
  *res\v[3]\f[1] = *m\v[3]\f[1] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[2]\f[0] = s + *m\v[2]\f[0]
  *res\v[2]\f[1] = s + *m\v[2]\f[1]
  *res\v[3]\f[0] = s + *m\v[3]\f[0]
  *res\v[3]\f[1] = s + *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[2]\f[0] = s - *m\v[2]\f[0]
  *res\v[2]\f[1] = s - *m\v[2]\f[1]
  *res\v[3]\f[0] = s - *m\v[3]\f[0]
  *res\v[3]\f[1] = s - *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[2]\f[0] = s * *m\v[2]\f[0]
  *res\v[2]\f[1] = s * *m\v[2]\f[1]
  *res\v[3]\f[0] = s * *m\v[3]\f[0]
  *res\v[3]\f[1] = s * *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat4x2(*res.Mat4x2, s.f, *m.Mat4x2)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[2]\f[0] = s / *m\v[2]\f[0]
  *res\v[2]\f[1] = s / *m\v[2]\f[1]
  *res\v[3]\f[0] = s / *m\v[3]\f[0]
  *res\v[3]\f[1] = s / *m\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_add(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[2]\f[0] = *m1\v[2]\f[0] + *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] + *m2\v[2]\f[1]
  *res\v[3]\f[0] = *m1\v[3]\f[0] + *m2\v[3]\f[0]
  *res\v[3]\f[1] = *m1\v[3]\f[1] + *m2\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_sub(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x2)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[2]\f[0] = *m1\v[2]\f[0] - *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] - *m2\v[2]\f[1]
  *res\v[3]\f[0] = *m1\v[3]\f[0] - *m2\v[3]\f[0]
  *res\v[3]\f[1] = *m1\v[3]\f[1] - *m2\v[3]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_mul_Mat2x4(*res.Mat2x2, *m1.Mat4x2, *m2.Mat2x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_mul_Mat3x4(*res.Mat3x2, *m1.Mat4x2, *m2.Mat3x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_mul_Mat4x4(*res.Mat4x2, *m1.Mat4x2, *m2.Mat4x4)
 Protected.Mat4x2 tmp
If *res=*m1
  Mat4x2_set(tmp, *m1)
  *m1=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2] + *m1\v[3]\f[0] * *m2\v[3]\f[3]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2] + *m1\v[3]\f[1] * *m2\v[3]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x2_mul_Vec4(*vecres.Vec2, *m.Mat4x2, *v.Vec4)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z + *m\v[3]\f[0] * *v\w
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z + *m\v[3]\f[1] * *v\w
  ProcedureReturn *vecres
EndProcedure
Procedure Vec2_mul_Mat4x2(*vecres.Vec4, *v.Vec2, *m.Mat4x2)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1]
*vecres\z = *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1]
*vecres\w = *v\x * *m\v[3]\f[0] + *v\y * *m\v[3]\f[1]
  ProcedureReturn *vecres
EndProcedure
;-Mat4x3
Procedure Mat4x3_set_float(*res.Mat4x3, x0.f, y0.f, z0.f, x1.f, y1.f, z1.f, x2.f, y2.f, z2.f, x3.f, y3.f, z3.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[0]\f[2] = z0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[1]\f[2] = z1
  *res\v[2]\f[0] = x2
  *res\v[2]\f[1] = y2
  *res\v[2]\f[2] = z2
  *res\v[3]\f[0] = x3
  *res\v[3]\f[1] = y3
  *res\v[3]\f[2] = z3
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_vec3(*res.Mat4x3, *v0.vec3, *v1.vec3, *v2.vec3, *v3.vec3)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[0]\f[2] = *v0\z
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[1]\f[2] = *v1\z
  *res\v[2]\f[0] = *v2\x
  *res\v[2]\f[1] = *v2\y
  *res\v[2]\f[2] = *v2\z
  *res\v[3]\f[0] = *v3\x
  *res\v[3]\f[1] = *v3\y
  *res\v[3]\f[2] = *v3\z
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat2x2(*res.Mat4x3, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat2x3(*res.Mat4x3, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat2x4(*res.Mat4x3, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat3x2(*res.Mat4x3, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat3x3(*res.Mat4x3, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat3x4(*res.Mat4x3, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat4x2(*res.Mat4x3, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set(*res.Mat4x3, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  *res\v[3]\f[2] = *m\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Mat4x4(*res.Mat4x3, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  *res\v[3]\f[2] = *m\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_set_Scalar(*res.Mat4x3, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[0]\f[2] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[1]\f[2] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = s
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_add_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[0]\f[2] = *m\v[0]\f[2] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[1]\f[2] = *m\v[1]\f[2] + s
  *res\v[2]\f[0] = *m\v[2]\f[0] + s
  *res\v[2]\f[1] = *m\v[2]\f[1] + s
  *res\v[2]\f[2] = *m\v[2]\f[2] + s
  *res\v[3]\f[0] = *m\v[3]\f[0] + s
  *res\v[3]\f[1] = *m\v[3]\f[1] + s
  *res\v[3]\f[2] = *m\v[3]\f[2] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_sub_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[0]\f[2] = *m\v[0]\f[2] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[1]\f[2] = *m\v[1]\f[2] - s
  *res\v[2]\f[0] = *m\v[2]\f[0] - s
  *res\v[2]\f[1] = *m\v[2]\f[1] - s
  *res\v[2]\f[2] = *m\v[2]\f[2] - s
  *res\v[3]\f[0] = *m\v[3]\f[0] - s
  *res\v[3]\f[1] = *m\v[3]\f[1] - s
  *res\v[3]\f[2] = *m\v[3]\f[2] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_mul_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[0]\f[2] = *m\v[0]\f[2] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[1]\f[2] = *m\v[1]\f[2] * s
  *res\v[2]\f[0] = *m\v[2]\f[0] * s
  *res\v[2]\f[1] = *m\v[2]\f[1] * s
  *res\v[2]\f[2] = *m\v[2]\f[2] * s
  *res\v[3]\f[0] = *m\v[3]\f[0] * s
  *res\v[3]\f[1] = *m\v[3]\f[1] * s
  *res\v[3]\f[2] = *m\v[3]\f[2] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_div_Scalar(*res.Mat4x3, *m.Mat4x3, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[0]\f[2] = *m\v[0]\f[2] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[1]\f[2] = *m\v[1]\f[2] / s
  *res\v[2]\f[0] = *m\v[2]\f[0] / s
  *res\v[2]\f[1] = *m\v[2]\f[1] / s
  *res\v[2]\f[2] = *m\v[2]\f[2] / s
  *res\v[3]\f[0] = *m\v[3]\f[0] / s
  *res\v[3]\f[1] = *m\v[3]\f[1] / s
  *res\v[3]\f[2] = *m\v[3]\f[2] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[0]\f[2] = s + *m\v[0]\f[2]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[1]\f[2] = s + *m\v[1]\f[2]
  *res\v[2]\f[0] = s + *m\v[2]\f[0]
  *res\v[2]\f[1] = s + *m\v[2]\f[1]
  *res\v[2]\f[2] = s + *m\v[2]\f[2]
  *res\v[3]\f[0] = s + *m\v[3]\f[0]
  *res\v[3]\f[1] = s + *m\v[3]\f[1]
  *res\v[3]\f[2] = s + *m\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[0]\f[2] = s - *m\v[0]\f[2]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[1]\f[2] = s - *m\v[1]\f[2]
  *res\v[2]\f[0] = s - *m\v[2]\f[0]
  *res\v[2]\f[1] = s - *m\v[2]\f[1]
  *res\v[2]\f[2] = s - *m\v[2]\f[2]
  *res\v[3]\f[0] = s - *m\v[3]\f[0]
  *res\v[3]\f[1] = s - *m\v[3]\f[1]
  *res\v[3]\f[2] = s - *m\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[0]\f[2] = s * *m\v[0]\f[2]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[1]\f[2] = s * *m\v[1]\f[2]
  *res\v[2]\f[0] = s * *m\v[2]\f[0]
  *res\v[2]\f[1] = s * *m\v[2]\f[1]
  *res\v[2]\f[2] = s * *m\v[2]\f[2]
  *res\v[3]\f[0] = s * *m\v[3]\f[0]
  *res\v[3]\f[1] = s * *m\v[3]\f[1]
  *res\v[3]\f[2] = s * *m\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat4x3(*res.Mat4x3, s.f, *m.Mat4x3)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[0]\f[2] = s / *m\v[0]\f[2]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[1]\f[2] = s / *m\v[1]\f[2]
  *res\v[2]\f[0] = s / *m\v[2]\f[0]
  *res\v[2]\f[1] = s / *m\v[2]\f[1]
  *res\v[2]\f[2] = s / *m\v[2]\f[2]
  *res\v[3]\f[0] = s / *m\v[3]\f[0]
  *res\v[3]\f[1] = s / *m\v[3]\f[1]
  *res\v[3]\f[2] = s / *m\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_add(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] + *m2\v[0]\f[2]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] + *m2\v[1]\f[2]
  *res\v[2]\f[0] = *m1\v[2]\f[0] + *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] + *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] + *m2\v[2]\f[2]
  *res\v[3]\f[0] = *m1\v[3]\f[0] + *m2\v[3]\f[0]
  *res\v[3]\f[1] = *m1\v[3]\f[1] + *m2\v[3]\f[1]
  *res\v[3]\f[2] = *m1\v[3]\f[2] + *m2\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_sub(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x3)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] - *m2\v[0]\f[2]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] - *m2\v[1]\f[2]
  *res\v[2]\f[0] = *m1\v[2]\f[0] - *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] - *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] - *m2\v[2]\f[2]
  *res\v[3]\f[0] = *m1\v[3]\f[0] - *m2\v[3]\f[0]
  *res\v[3]\f[1] = *m1\v[3]\f[1] - *m2\v[3]\f[1]
  *res\v[3]\f[2] = *m1\v[3]\f[2] - *m2\v[3]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_mul_Mat2x4(*res.Mat2x3, *m1.Mat4x3, *m2.Mat2x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_mul_Mat3x4(*res.Mat3x3, *m1.Mat4x3, *m2.Mat3x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_mul_Mat4x4(*res.Mat4x3, *m1.Mat4x3, *m2.Mat4x4)
 Protected.Mat4x3 tmp
If *res=*m1
  Mat4x3_set(tmp, *m1)
  *m1=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2] + *m1\v[3]\f[0] * *m2\v[3]\f[3]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2] + *m1\v[3]\f[1] * *m2\v[3]\f[3]
  *res\v[3]\f[2] = *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2] + *m1\v[3]\f[2] * *m2\v[3]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x3_mul_Vec4(*vecres.Vec3, *m.Mat4x3, *v.Vec4)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z + *m\v[3]\f[0] * *v\w
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z + *m\v[3]\f[1] * *v\w
*vecres\z = *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z + *m\v[3]\f[2] * *v\w
  ProcedureReturn *vecres
EndProcedure
Procedure Vec3_mul_Mat4x3(*vecres.Vec4, *v.Vec3, *m.Mat4x3)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2]
*vecres\z = *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2]
*vecres\w = *v\x * *m\v[3]\f[0] + *v\y * *m\v[3]\f[1] + *v\z * *m\v[3]\f[2]
  ProcedureReturn *vecres
EndProcedure
;-Mat4x4
Procedure Mat4x4_set_float(*res.Mat4x4, x0.f, y0.f, z0.f, w0.f, x1.f, y1.f, z1.f, w1.f, x2.f, y2.f, z2.f, w2.f, x3.f, y3.f, z3.f, w3.f)
  *res\v[0]\f[0] = x0
  *res\v[0]\f[1] = y0
  *res\v[0]\f[2] = z0
  *res\v[0]\f[3] = w0
  *res\v[1]\f[0] = x1
  *res\v[1]\f[1] = y1
  *res\v[1]\f[2] = z1
  *res\v[1]\f[3] = w1
  *res\v[2]\f[0] = x2
  *res\v[2]\f[1] = y2
  *res\v[2]\f[2] = z2
  *res\v[2]\f[3] = w2
  *res\v[3]\f[0] = x3
  *res\v[3]\f[1] = y3
  *res\v[3]\f[2] = z3
  *res\v[3]\f[3] = w3
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_vec4(*res.Mat4x4, *v0.vec4, *v1.vec4, *v2.vec4, *v3.vec4)
  *res\v[0]\f[0] = *v0\x
  *res\v[0]\f[1] = *v0\y
  *res\v[0]\f[2] = *v0\z
  *res\v[0]\f[3] = *v0\w
  *res\v[1]\f[0] = *v1\x
  *res\v[1]\f[1] = *v1\y
  *res\v[1]\f[2] = *v1\z
  *res\v[1]\f[3] = *v1\w
  *res\v[2]\f[0] = *v2\x
  *res\v[2]\f[1] = *v2\y
  *res\v[2]\f[2] = *v2\z
  *res\v[2]\f[3] = *v2\w
  *res\v[3]\f[0] = *v3\x
  *res\v[3]\f[1] = *v3\y
  *res\v[3]\f[2] = *v3\z
  *res\v[3]\f[3] = *v3\w
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat2x2(*res.Mat4x4, *m.Mat2x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat2x3(*res.Mat4x4, *m.Mat2x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat2x4(*res.Mat4x4, *m.Mat2x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat3x2(*res.Mat4x4, *m.Mat3x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat3x3(*res.Mat4x4, *m.Mat3x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat3x4(*res.Mat4x4, *m.Mat3x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = *m\v[2]\f[3]
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat4x2(*res.Mat4x4, *m.Mat4x2)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = 1.0
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Mat4x3(*res.Mat4x4, *m.Mat4x3)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  *res\v[3]\f[2] = *m\v[3]\f[2]
  *res\v[3]\f[3] = 1.0
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set(*res.Mat4x4, *m.Mat4x4)
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[0]\f[1]
  *res\v[0]\f[2] = *m\v[0]\f[2]
  *res\v[0]\f[3] = *m\v[0]\f[3]
  *res\v[1]\f[0] = *m\v[1]\f[0]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[1]\f[2]
  *res\v[1]\f[3] = *m\v[1]\f[3]
  *res\v[2]\f[0] = *m\v[2]\f[0]
  *res\v[2]\f[1] = *m\v[2]\f[1]
  *res\v[2]\f[2] = *m\v[2]\f[2]
  *res\v[2]\f[3] = *m\v[2]\f[3]
  *res\v[3]\f[0] = *m\v[3]\f[0]
  *res\v[3]\f[1] = *m\v[3]\f[1]
  *res\v[3]\f[2] = *m\v[3]\f[2]
  *res\v[3]\f[3] = *m\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_set_Scalar(*res.Mat4x4, s.f)
  *res\v[0]\f[0] = s
  *res\v[0]\f[1] = 0.0
  *res\v[0]\f[2] = 0.0
  *res\v[0]\f[3] = 0.0
  *res\v[1]\f[0] = 0.0
  *res\v[1]\f[1] = s
  *res\v[1]\f[2] = 0.0
  *res\v[1]\f[3] = 0.0
  *res\v[2]\f[0] = 0.0
  *res\v[2]\f[1] = 0.0
  *res\v[2]\f[2] = s
  *res\v[2]\f[3] = 0.0
  *res\v[3]\f[0] = 0.0
  *res\v[3]\f[1] = 0.0
  *res\v[3]\f[2] = 0.0
  *res\v[3]\f[3] = s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_add_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] + s
  *res\v[0]\f[1] = *m\v[0]\f[1] + s
  *res\v[0]\f[2] = *m\v[0]\f[2] + s
  *res\v[0]\f[3] = *m\v[0]\f[3] + s
  *res\v[1]\f[0] = *m\v[1]\f[0] + s
  *res\v[1]\f[1] = *m\v[1]\f[1] + s
  *res\v[1]\f[2] = *m\v[1]\f[2] + s
  *res\v[1]\f[3] = *m\v[1]\f[3] + s
  *res\v[2]\f[0] = *m\v[2]\f[0] + s
  *res\v[2]\f[1] = *m\v[2]\f[1] + s
  *res\v[2]\f[2] = *m\v[2]\f[2] + s
  *res\v[2]\f[3] = *m\v[2]\f[3] + s
  *res\v[3]\f[0] = *m\v[3]\f[0] + s
  *res\v[3]\f[1] = *m\v[3]\f[1] + s
  *res\v[3]\f[2] = *m\v[3]\f[2] + s
  *res\v[3]\f[3] = *m\v[3]\f[3] + s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_sub_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] - s
  *res\v[0]\f[1] = *m\v[0]\f[1] - s
  *res\v[0]\f[2] = *m\v[0]\f[2] - s
  *res\v[0]\f[3] = *m\v[0]\f[3] - s
  *res\v[1]\f[0] = *m\v[1]\f[0] - s
  *res\v[1]\f[1] = *m\v[1]\f[1] - s
  *res\v[1]\f[2] = *m\v[1]\f[2] - s
  *res\v[1]\f[3] = *m\v[1]\f[3] - s
  *res\v[2]\f[0] = *m\v[2]\f[0] - s
  *res\v[2]\f[1] = *m\v[2]\f[1] - s
  *res\v[2]\f[2] = *m\v[2]\f[2] - s
  *res\v[2]\f[3] = *m\v[2]\f[3] - s
  *res\v[3]\f[0] = *m\v[3]\f[0] - s
  *res\v[3]\f[1] = *m\v[3]\f[1] - s
  *res\v[3]\f[2] = *m\v[3]\f[2] - s
  *res\v[3]\f[3] = *m\v[3]\f[3] - s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_mul_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] * s
  *res\v[0]\f[1] = *m\v[0]\f[1] * s
  *res\v[0]\f[2] = *m\v[0]\f[2] * s
  *res\v[0]\f[3] = *m\v[0]\f[3] * s
  *res\v[1]\f[0] = *m\v[1]\f[0] * s
  *res\v[1]\f[1] = *m\v[1]\f[1] * s
  *res\v[1]\f[2] = *m\v[1]\f[2] * s
  *res\v[1]\f[3] = *m\v[1]\f[3] * s
  *res\v[2]\f[0] = *m\v[2]\f[0] * s
  *res\v[2]\f[1] = *m\v[2]\f[1] * s
  *res\v[2]\f[2] = *m\v[2]\f[2] * s
  *res\v[2]\f[3] = *m\v[2]\f[3] * s
  *res\v[3]\f[0] = *m\v[3]\f[0] * s
  *res\v[3]\f[1] = *m\v[3]\f[1] * s
  *res\v[3]\f[2] = *m\v[3]\f[2] * s
  *res\v[3]\f[3] = *m\v[3]\f[3] * s
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_div_Scalar(*res.Mat4x4, *m.Mat4x4, s.f)
  *res\v[0]\f[0] = *m\v[0]\f[0] / s
  *res\v[0]\f[1] = *m\v[0]\f[1] / s
  *res\v[0]\f[2] = *m\v[0]\f[2] / s
  *res\v[0]\f[3] = *m\v[0]\f[3] / s
  *res\v[1]\f[0] = *m\v[1]\f[0] / s
  *res\v[1]\f[1] = *m\v[1]\f[1] / s
  *res\v[1]\f[2] = *m\v[1]\f[2] / s
  *res\v[1]\f[3] = *m\v[1]\f[3] / s
  *res\v[2]\f[0] = *m\v[2]\f[0] / s
  *res\v[2]\f[1] = *m\v[2]\f[1] / s
  *res\v[2]\f[2] = *m\v[2]\f[2] / s
  *res\v[2]\f[3] = *m\v[2]\f[3] / s
  *res\v[3]\f[0] = *m\v[3]\f[0] / s
  *res\v[3]\f[1] = *m\v[3]\f[1] / s
  *res\v[3]\f[2] = *m\v[3]\f[2] / s
  *res\v[3]\f[3] = *m\v[3]\f[3] / s
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
  *res\v[0]\f[0] = s + *m\v[0]\f[0]
  *res\v[0]\f[1] = s + *m\v[0]\f[1]
  *res\v[0]\f[2] = s + *m\v[0]\f[2]
  *res\v[0]\f[3] = s + *m\v[0]\f[3]
  *res\v[1]\f[0] = s + *m\v[1]\f[0]
  *res\v[1]\f[1] = s + *m\v[1]\f[1]
  *res\v[1]\f[2] = s + *m\v[1]\f[2]
  *res\v[1]\f[3] = s + *m\v[1]\f[3]
  *res\v[2]\f[0] = s + *m\v[2]\f[0]
  *res\v[2]\f[1] = s + *m\v[2]\f[1]
  *res\v[2]\f[2] = s + *m\v[2]\f[2]
  *res\v[2]\f[3] = s + *m\v[2]\f[3]
  *res\v[3]\f[0] = s + *m\v[3]\f[0]
  *res\v[3]\f[1] = s + *m\v[3]\f[1]
  *res\v[3]\f[2] = s + *m\v[3]\f[2]
  *res\v[3]\f[3] = s + *m\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
  *res\v[0]\f[0] = s - *m\v[0]\f[0]
  *res\v[0]\f[1] = s - *m\v[0]\f[1]
  *res\v[0]\f[2] = s - *m\v[0]\f[2]
  *res\v[0]\f[3] = s - *m\v[0]\f[3]
  *res\v[1]\f[0] = s - *m\v[1]\f[0]
  *res\v[1]\f[1] = s - *m\v[1]\f[1]
  *res\v[1]\f[2] = s - *m\v[1]\f[2]
  *res\v[1]\f[3] = s - *m\v[1]\f[3]
  *res\v[2]\f[0] = s - *m\v[2]\f[0]
  *res\v[2]\f[1] = s - *m\v[2]\f[1]
  *res\v[2]\f[2] = s - *m\v[2]\f[2]
  *res\v[2]\f[3] = s - *m\v[2]\f[3]
  *res\v[3]\f[0] = s - *m\v[3]\f[0]
  *res\v[3]\f[1] = s - *m\v[3]\f[1]
  *res\v[3]\f[2] = s - *m\v[3]\f[2]
  *res\v[3]\f[3] = s - *m\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
  *res\v[0]\f[0] = s * *m\v[0]\f[0]
  *res\v[0]\f[1] = s * *m\v[0]\f[1]
  *res\v[0]\f[2] = s * *m\v[0]\f[2]
  *res\v[0]\f[3] = s * *m\v[0]\f[3]
  *res\v[1]\f[0] = s * *m\v[1]\f[0]
  *res\v[1]\f[1] = s * *m\v[1]\f[1]
  *res\v[1]\f[2] = s * *m\v[1]\f[2]
  *res\v[1]\f[3] = s * *m\v[1]\f[3]
  *res\v[2]\f[0] = s * *m\v[2]\f[0]
  *res\v[2]\f[1] = s * *m\v[2]\f[1]
  *res\v[2]\f[2] = s * *m\v[2]\f[2]
  *res\v[2]\f[3] = s * *m\v[2]\f[3]
  *res\v[3]\f[0] = s * *m\v[3]\f[0]
  *res\v[3]\f[1] = s * *m\v[3]\f[1]
  *res\v[3]\f[2] = s * *m\v[3]\f[2]
  *res\v[3]\f[3] = s * *m\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_Mat4x4(*res.Mat4x4, s.f, *m.Mat4x4)
  *res\v[0]\f[0] = s / *m\v[0]\f[0]
  *res\v[0]\f[1] = s / *m\v[0]\f[1]
  *res\v[0]\f[2] = s / *m\v[0]\f[2]
  *res\v[0]\f[3] = s / *m\v[0]\f[3]
  *res\v[1]\f[0] = s / *m\v[1]\f[0]
  *res\v[1]\f[1] = s / *m\v[1]\f[1]
  *res\v[1]\f[2] = s / *m\v[1]\f[2]
  *res\v[1]\f[3] = s / *m\v[1]\f[3]
  *res\v[2]\f[0] = s / *m\v[2]\f[0]
  *res\v[2]\f[1] = s / *m\v[2]\f[1]
  *res\v[2]\f[2] = s / *m\v[2]\f[2]
  *res\v[2]\f[3] = s / *m\v[2]\f[3]
  *res\v[3]\f[0] = s / *m\v[3]\f[0]
  *res\v[3]\f[1] = s / *m\v[3]\f[1]
  *res\v[3]\f[2] = s / *m\v[3]\f[2]
  *res\v[3]\f[3] = s / *m\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_add(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] + *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] + *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] + *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] + *m2\v[0]\f[3]
  *res\v[1]\f[0] = *m1\v[1]\f[0] + *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] + *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] + *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[1]\f[3] + *m2\v[1]\f[3]
  *res\v[2]\f[0] = *m1\v[2]\f[0] + *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] + *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] + *m2\v[2]\f[2]
  *res\v[2]\f[3] = *m1\v[2]\f[3] + *m2\v[2]\f[3]
  *res\v[3]\f[0] = *m1\v[3]\f[0] + *m2\v[3]\f[0]
  *res\v[3]\f[1] = *m1\v[3]\f[1] + *m2\v[3]\f[1]
  *res\v[3]\f[2] = *m1\v[3]\f[2] + *m2\v[3]\f[2]
  *res\v[3]\f[3] = *m1\v[3]\f[3] + *m2\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_sub(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
  *res\v[0]\f[0] = *m1\v[0]\f[0] - *m2\v[0]\f[0]
  *res\v[0]\f[1] = *m1\v[0]\f[1] - *m2\v[0]\f[1]
  *res\v[0]\f[2] = *m1\v[0]\f[2] - *m2\v[0]\f[2]
  *res\v[0]\f[3] = *m1\v[0]\f[3] - *m2\v[0]\f[3]
  *res\v[1]\f[0] = *m1\v[1]\f[0] - *m2\v[1]\f[0]
  *res\v[1]\f[1] = *m1\v[1]\f[1] - *m2\v[1]\f[1]
  *res\v[1]\f[2] = *m1\v[1]\f[2] - *m2\v[1]\f[2]
  *res\v[1]\f[3] = *m1\v[1]\f[3] - *m2\v[1]\f[3]
  *res\v[2]\f[0] = *m1\v[2]\f[0] - *m2\v[2]\f[0]
  *res\v[2]\f[1] = *m1\v[2]\f[1] - *m2\v[2]\f[1]
  *res\v[2]\f[2] = *m1\v[2]\f[2] - *m2\v[2]\f[2]
  *res\v[2]\f[3] = *m1\v[2]\f[3] - *m2\v[2]\f[3]
  *res\v[3]\f[0] = *m1\v[3]\f[0] - *m2\v[3]\f[0]
  *res\v[3]\f[1] = *m1\v[3]\f[1] - *m2\v[3]\f[1]
  *res\v[3]\f[2] = *m1\v[3]\f[2] - *m2\v[3]\f[2]
  *res\v[3]\f[3] = *m1\v[3]\f[3] - *m2\v[3]\f[3]
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_mul_Mat2x4(*res.Mat2x4, *m1.Mat4x4, *m2.Mat2x4)
 Protected.Mat2x4 tmp
If *res=*m2
  Mat2x4_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2] + *m1\v[3]\f[3] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2] + *m1\v[3]\f[3] * *m2\v[1]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_mul_Mat3x4(*res.Mat3x4, *m1.Mat4x4, *m2.Mat3x4)
 Protected.Mat3x4 tmp
If *res=*m2
  Mat3x4_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2] + *m1\v[3]\f[3] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2] + *m1\v[3]\f[3] * *m2\v[1]\f[3]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3]
  *res\v[2]\f[3] = *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2] + *m1\v[3]\f[3] * *m2\v[2]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_mul(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
 Protected.Mat4x4 tmp
If *res = *m1 And *res = *m2
  Mat4x4_set(tmp, *m1)
  *m1=@tmp
  *m2=@tmp
ElseIf *res=*m1
  Mat4x4_set(tmp, *m1)
  *m1=@tmp
ElseIf *res=*m2
  Mat4x4_set(tmp, *m2)
  *m2=@tmp
EndIf
  *res\v[0]\f[0] = *m1\v[0]\f[0] * *m2\v[0]\f[0] + *m1\v[1]\f[0] * *m2\v[0]\f[1] + *m1\v[2]\f[0] * *m2\v[0]\f[2] + *m1\v[3]\f[0] * *m2\v[0]\f[3]
  *res\v[0]\f[1] = *m1\v[0]\f[1] * *m2\v[0]\f[0] + *m1\v[1]\f[1] * *m2\v[0]\f[1] + *m1\v[2]\f[1] * *m2\v[0]\f[2] + *m1\v[3]\f[1] * *m2\v[0]\f[3]
  *res\v[0]\f[2] = *m1\v[0]\f[2] * *m2\v[0]\f[0] + *m1\v[1]\f[2] * *m2\v[0]\f[1] + *m1\v[2]\f[2] * *m2\v[0]\f[2] + *m1\v[3]\f[2] * *m2\v[0]\f[3]
  *res\v[0]\f[3] = *m1\v[0]\f[3] * *m2\v[0]\f[0] + *m1\v[1]\f[3] * *m2\v[0]\f[1] + *m1\v[2]\f[3] * *m2\v[0]\f[2] + *m1\v[3]\f[3] * *m2\v[0]\f[3]
;
  *res\v[1]\f[0] = *m1\v[0]\f[0] * *m2\v[1]\f[0] + *m1\v[1]\f[0] * *m2\v[1]\f[1] + *m1\v[2]\f[0] * *m2\v[1]\f[2] + *m1\v[3]\f[0] * *m2\v[1]\f[3]
  *res\v[1]\f[1] = *m1\v[0]\f[1] * *m2\v[1]\f[0] + *m1\v[1]\f[1] * *m2\v[1]\f[1] + *m1\v[2]\f[1] * *m2\v[1]\f[2] + *m1\v[3]\f[1] * *m2\v[1]\f[3]
  *res\v[1]\f[2] = *m1\v[0]\f[2] * *m2\v[1]\f[0] + *m1\v[1]\f[2] * *m2\v[1]\f[1] + *m1\v[2]\f[2] * *m2\v[1]\f[2] + *m1\v[3]\f[2] * *m2\v[1]\f[3]
  *res\v[1]\f[3] = *m1\v[0]\f[3] * *m2\v[1]\f[0] + *m1\v[1]\f[3] * *m2\v[1]\f[1] + *m1\v[2]\f[3] * *m2\v[1]\f[2] + *m1\v[3]\f[3] * *m2\v[1]\f[3]
;
  *res\v[2]\f[0] = *m1\v[0]\f[0] * *m2\v[2]\f[0] + *m1\v[1]\f[0] * *m2\v[2]\f[1] + *m1\v[2]\f[0] * *m2\v[2]\f[2] + *m1\v[3]\f[0] * *m2\v[2]\f[3]
  *res\v[2]\f[1] = *m1\v[0]\f[1] * *m2\v[2]\f[0] + *m1\v[1]\f[1] * *m2\v[2]\f[1] + *m1\v[2]\f[1] * *m2\v[2]\f[2] + *m1\v[3]\f[1] * *m2\v[2]\f[3]
  *res\v[2]\f[2] = *m1\v[0]\f[2] * *m2\v[2]\f[0] + *m1\v[1]\f[2] * *m2\v[2]\f[1] + *m1\v[2]\f[2] * *m2\v[2]\f[2] + *m1\v[3]\f[2] * *m2\v[2]\f[3]
  *res\v[2]\f[3] = *m1\v[0]\f[3] * *m2\v[2]\f[0] + *m1\v[1]\f[3] * *m2\v[2]\f[1] + *m1\v[2]\f[3] * *m2\v[2]\f[2] + *m1\v[3]\f[3] * *m2\v[2]\f[3]
;
  *res\v[3]\f[0] = *m1\v[0]\f[0] * *m2\v[3]\f[0] + *m1\v[1]\f[0] * *m2\v[3]\f[1] + *m1\v[2]\f[0] * *m2\v[3]\f[2] + *m1\v[3]\f[0] * *m2\v[3]\f[3]
  *res\v[3]\f[1] = *m1\v[0]\f[1] * *m2\v[3]\f[0] + *m1\v[1]\f[1] * *m2\v[3]\f[1] + *m1\v[2]\f[1] * *m2\v[3]\f[2] + *m1\v[3]\f[1] * *m2\v[3]\f[3]
  *res\v[3]\f[2] = *m1\v[0]\f[2] * *m2\v[3]\f[0] + *m1\v[1]\f[2] * *m2\v[3]\f[1] + *m1\v[2]\f[2] * *m2\v[3]\f[2] + *m1\v[3]\f[2] * *m2\v[3]\f[3]
  *res\v[3]\f[3] = *m1\v[0]\f[3] * *m2\v[3]\f[0] + *m1\v[1]\f[3] * *m2\v[3]\f[1] + *m1\v[2]\f[3] * *m2\v[3]\f[2] + *m1\v[3]\f[3] * *m2\v[3]\f[3]
;
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_div(*res.Mat4x4, *m1.Mat4x4, *m2.Mat4x4)
  Protected.Mat4x4 tmp
  Mat4x4_inverse(tmp, *m2)
  Mat4x4_mul(*res, *m1, tmp)
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_div_vec4(*res.Mat4x4, *m.Mat4x4, *v.vec4)
  Protected.Mat4x4 tmp
  Mat4x4_inverse(tmp, *m)
  Mat4x4_mul_vec4(*res, tmp, *v)
  ProcedureReturn *res
EndProcedure
Procedure vec4_div_Mat4x4(*res.Mat4x4, *v.vec4, *m.Mat4x4 )
  Protected.Mat4x4 tmp
  Mat4x4_inverse(tmp, *m)
  vec4_mul_Mat4x4(*res, *v, tmp)
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_mul_Vec4(*vecres.Vec4, *m.Mat4x4, *v.Vec4)
*vecres\x = *m\v[0]\f[0] * *v\x + *m\v[1]\f[0] * *v\y + *m\v[2]\f[0] * *v\z + *m\v[3]\f[0] * *v\w
*vecres\y = *m\v[0]\f[1] * *v\x + *m\v[1]\f[1] * *v\y + *m\v[2]\f[1] * *v\z + *m\v[3]\f[1] * *v\w
*vecres\z = *m\v[0]\f[2] * *v\x + *m\v[1]\f[2] * *v\y + *m\v[2]\f[2] * *v\z + *m\v[3]\f[2] * *v\w
*vecres\w = *m\v[0]\f[3] * *v\x + *m\v[1]\f[3] * *v\y + *m\v[2]\f[3] * *v\z + *m\v[3]\f[3] * *v\w
  ProcedureReturn *vecres
EndProcedure
Procedure Vec4_mul_Mat4x4(*vecres.Vec4, *v.Vec4, *m.Mat4x4)
*vecres\x = *v\x * *m\v[0]\f[0] + *v\y * *m\v[0]\f[1] + *v\z * *m\v[0]\f[2] + *v\w * *m\v[0]\f[3]
*vecres\y = *v\x * *m\v[1]\f[0] + *v\y * *m\v[1]\f[1] + *v\z * *m\v[1]\f[2] + *v\w * *m\v[1]\f[3]
*vecres\z = *v\x * *m\v[2]\f[0] + *v\y * *m\v[2]\f[1] + *v\z * *m\v[2]\f[2] + *v\w * *m\v[2]\f[3]
*vecres\w = *v\x * *m\v[3]\f[0] + *v\y * *m\v[3]\f[1] + *v\z * *m\v[3]\f[2] + *v\w * *m\v[3]\f[3]
  ProcedureReturn *vecres
EndProcedure
;}
;-----------------------
;- func_matrix_inl.pbi
;{

UseModule math
Procedure Mat2x2_inverse(*res.Mat2x2, *m.Mat2x2)
  Protected.f OneOverDeterminant = 1.0 / (*m\v[0]\f[0] * *m\v[1]\f[1]	- *m\v[1]\f[0] * *m\v[0]\f[1])
  If *res = *m
    Protected.mat2x2 tmp
    mat2x2_set(tmp,*m)
    *m=@tmp
  EndIf
  mat2x2_set_float(*res,
                   *m\v[1]\f[1] * OneOverDeterminant,
                   - *m\v[0]\f[1] * OneOverDeterminant,
                   - *m\v[1]\f[0] * OneOverDeterminant,
                   *m\v[0]\f[0] * OneOverDeterminant)
  ProcedureReturn *res  
EndProcedure
Procedure Mat3x3_inverse(*res.Mat3x3, *m.Mat3x3)  
  Protected.f OneOverDeterminant = 1.0 / (*m\v[0]\f[0] * (*m\v[1]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[1]\f[2]) - *m\v[1]\f[0] * (*m\v[0]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[0]\f[2])	+ *m\v[2]\f[0] * (*m\v[0]\f[1] * *m\v[1]\f[2] - *m\v[1]\f[1] * *m\v[0]\f[2]))
  If *res = *m
    Protected.mat3x3 tmp
    mat3x3_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure Mat4x4_inverse(*res.mat4x4, *m.Mat4x4)
  If *res = *m
    Protected.mat4x4 tmp
    mat3x3_set(tmp,*m)
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
  vec4_set_float( Fac0, Coef00, Coef00, Coef02, Coef03)
  vec4_set_float( Fac1, Coef04, Coef04, Coef06, Coef07)
  vec4_set_float( Fac2, Coef08, Coef08, Coef10, Coef11)
  vec4_set_float( Fac3, Coef12, Coef12, Coef14, Coef15)
  vec4_set_float( Fac4, Coef16, Coef16, Coef18, Coef19)
  vec4_set_float( Fac5, Coef20, Coef20, Coef22, Coef23)
  vec4_set_float( VecA, *m\v[1]\f[0], *m\v[0]\f[0], *m\v[0]\f[0], *m\v[0]\f[0])
  vec4_set_float( VecB, *m\v[1]\f[1], *m\v[0]\f[1], *m\v[0]\f[1], *m\v[0]\f[1])
  vec4_set_float( VecC, *m\v[1]\f[2], *m\v[0]\f[2], *m\v[0]\f[2], *m\v[0]\f[2])
  vec4_set_float( VecD, *m\v[1]\f[3], *m\v[0]\f[3], *m\v[0]\f[3], *m\v[0]\f[3])
  vec4_mul(tmp1, VecB, Fac0)
  vec4_mul(tmp2, VecC, Fac1)
  vec4_mul(tmp3, VecD, Fac2)
  vec4_sub(Inv0, tmp1, tmp2):vec4_add(inv0, inv0, tmp3)
  vec4_mul(tmp1, VecA, Fac0)
  vec4_mul(tmp2, VecC, Fac3)
  vec4_mul(tmp3, VecD, Fac4)
  vec4_sub(Inv1, tmp1, tmp2):vec4_add(inv1, inv1, tmp3)
  vec4_mul(tmp1, VecA, Fac1)
  vec4_mul(tmp2, VecB, Fac3)
  vec4_mul(tmp3, VecD, Fac5)
  vec4_sub(Inv2, tmp1, tmp2):vec4_add(inv2, inv2, tmp3)
  vec4_mul(tmp1, VecA, Fac2)
  vec4_mul(tmp2, VecB, Fac4)
  vec4_mul(tmp3, VecC, Fac5)
  vec4_sub(Inv3, tmp1, tmp2):vec4_add(inv3, inv3, tmp3)
  vec4_set_float( SignA,  1, -1,  1, -1)
  vec4_set_float( SignB, -1,  1, -1,  1)
  vec4_mul( *res\v[0], Inv0, SignA)
  vec4_mul( *res\v[1], Inv1, SignB)
  vec4_mul( *res\v[2], Inv2, SignA)
  vec4_mul( *res\v[3], Inv3, SignB)
  Protected.vec4 Row0, Dot0
  vec4_set_float(Row0, *res\v[0]\f[0], *res\v[1]\f[0], *res\v[2]\f[0], *res\v[3]\f[0])
  vec4_mul(Dot0, *m\v[0], Row0)
  Protected.f Dot1 = (Dot0\x + Dot0\y) + (Dot0\z + Dot0\w)
  Protected.f OneOverDeterminant = 1.0 / Dot1
  Mat4x4_mul_Scalar(*res, *res, OneOverDeterminant)
  ProcedureReturn *res
EndProcedure
Procedure mat2x2_transpose(*res.mat2x2, *m.mat2x2)
  If *res = *m
    Protected.mat2x2 tmp
    mat2x2_set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure mat2x3_transpose(*res.mat2x3, *m.mat3x2)
  If *res = *m
    Protected.mat3x2 tmp
    mat3x2_set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[0]\f[2] = *m\v[2]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[1]\f[2] = *m\v[2]\f[1]
  ProcedureReturn *res
EndProcedure
Procedure mat2x4_transpose(*res.mat2x4, *m.mat4x2)
  If *res = *m
    Protected.mat4x2 tmp
    mat4x2_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure mat3x2_transpose(*res.mat3x2, *m.mat2x3)
  If *res = *m
    Protected.mat2x3 tmp
    mat2x3_set(tmp,*m)
    *m=@tmp
  EndIf
  *res\v[0]\f[0] = *m\v[0]\f[0]
  *res\v[0]\f[1] = *m\v[1]\f[0]
  *res\v[1]\f[0] = *m\v[0]\f[1]
  *res\v[1]\f[1] = *m\v[1]\f[1]
  *res\v[2]\f[0] = *m\v[0]\f[2]
  *res\v[2]\f[1] = *m\v[1]\f[2]
  ProcedureReturn *res
EndProcedure
Procedure mat3x3_transpose(*res.mat3x3, *m.mat3x3)
  If *res = *m
    Protected.mat3x3 tmp
    mat3x3_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure mat3x4_transpose(*res.mat3x4, *m.mat4x3)
  If *res = *m
    Protected.mat4x3 tmp
    mat4x3_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure mat4x2_transpose(*res.mat4x2, *m.mat2x4)
  If *res = *m
    Protected.mat2x4 tmp
    mat2x4_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure mat4x3_transpose(*res.mat4x3, *m.mat3x4)
  If *res = *m
    Protected.mat3x4 tmp
    mat3x4_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure mat4x4_transpose(*res.mat4x4, *m.mat4x4)
  If *res = *m
    Protected.mat4x4 tmp
    mat4x4_set(tmp,*m)
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
  ProcedureReturn *res
EndProcedure
Procedure.f mat2x2_determinant(*m.mat2x2)
  ProcedureReturn *m\v[0]\f[0] * *m\v[1]\f[1] - *m\v[1]\f[0] * *m\v[0]\f[1]
EndProcedure
Procedure.f mat3x3_determinant(*m.mat3x3)
  ProcedureReturn *m\v[0]\f[0] * (*m\v[1]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[1]\f[2]) - *m\v[1]\f[0] * (*m\v[0]\f[1] * *m\v[2]\f[2] - *m\v[2]\f[1] * *m\v[0]\f[2])	+ *m\v[2]\f[0] * (*m\v[0]\f[1] * *m\v[1]\f[2] - *m\v[1]\f[1] * *m\v[0]\f[2])
EndProcedure
Procedure.f mat4x4_determinant(*m.mat4x4)
  Protected.f SubFactor00 = *m\v[2]\f[2] * *m\v[3]\f[3] - *m\v[3]\f[2] * *m\v[2]\f[3];
  Protected.f SubFactor01 = *m\v[2]\f[1] * *m\v[3]\f[3] - *m\v[3]\f[1] * *m\v[2]\f[3];
  Protected.f SubFactor02 = *m\v[2]\f[1] * *m\v[3]\f[2] - *m\v[3]\f[1] * *m\v[2]\f[2];
  Protected.f SubFactor03 = *m\v[2]\f[0] * *m\v[3]\f[3] - *m\v[3]\f[0] * *m\v[2]\f[3];
  Protected.f SubFactor04 = *m\v[2]\f[0] * *m\v[3]\f[2] - *m\v[3]\f[0] * *m\v[2]\f[2];
  Protected.f SubFactor05 = *m\v[2]\f[0] * *m\v[3]\f[1] - *m\v[3]\f[0] * *m\v[2]\f[1];
  Protected.vec4 DetCof
  vec4_set_float(DetCof,  
                 (*m\v[1]\f[1] * SubFactor00 - *m\v[1]\f[2] * SubFactor01 + *m\v[1]\f[3] * SubFactor02),
                 - (*m\v[1]\f[0] * SubFactor00 - *m\v[1]\f[2] * SubFactor03 + *m\v[1]\f[3] * SubFactor04),
                 (*m\v[1]\f[0] * SubFactor01 - *m\v[1]\f[1] * SubFactor03 + *m\v[1]\f[3] * SubFactor05),
                 - (*m\v[1]\f[0] * SubFactor02 - *m\v[1]\f[1] * SubFactor04 + *m\v[1]\f[2] * SubFactor05))
  ProcedureReturn		*m\v[0]\f[0] * DetCof\f[0] + *m\v[0]\f[1] * DetCof\f[1] +	*m\v[0]\f[2] * DetCof\f[2] + *m\v[0]\f[3] * DetCof\f[3]
EndProcedure
			
;}
;-----------------------
;- type_vector_inl.pbi
;{

Procedure vec2_set_float(*res.vec2, x.f=0.0, y.f=0.0)
  *res\x = x
  *res\y = y
  ProcedureReturn *res
EndProcedure
Procedure vec2_set_Scalar(*res.vec2, s.f)
  *res\x = s
  *res\y = s
  ProcedureReturn *res
EndProcedure
Procedure vec2_set(*res.vec2, *v.vec2)
  *res\x = *v\x
  *res\y = *v\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_set_vec3(*res.vec2, *v.vec3)
  *res\x = *v\x
  *res\y = *v\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_set_vec4(*res.vec2, *v.vec4)
  *res\x = *v\x
  *res\y = *v\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_add(*res.vec2, *v1.vec2, *v2.vec2)
  *res\x = *v1\x + *v2\x
  *res\y = *v1\y + *v2\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_sub(*res.vec2, *v1.vec2, *v2.vec2)
  *res\x = *v1\x - *v2\x
  *res\y = *v1\y - *v2\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_mul(*res.vec2, *v1.vec2, *v2.vec2)
  *res\x = *v1\x * *v2\x
  *res\y = *v1\y * *v2\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_div(*res.vec2, *v1.vec2, *v2.vec2)
  *res\x = *v1\x / *v2\x
  *res\y = *v1\y / *v2\y
  ProcedureReturn *res
EndProcedure
Procedure vec2_add_scalar(*res.vec2, *v1.vec2, s.f)
  *res\x = *v1\x + s
  *res\y = *v1\y + s
  ProcedureReturn *res
EndProcedure
Procedure vec2_sub_scalar(*res.vec2, *v1.vec2, s.f)
  *res\x = *v1\x - s
  *res\y = *v1\y - s
  ProcedureReturn *res
EndProcedure
Procedure vec2_mul_scalar(*res.vec2, *v1.vec2, s.f)
  *res\x = *v1\x * s
  *res\y = *v1\y * s
  ProcedureReturn *res
EndProcedure
Procedure vec2_div_scalar(*res.vec2, *v1.vec2, s.f)
  *res\x = *v1\x / s
  *res\y = *v1\y / s
  ProcedureReturn *res
EndProcedure
Procedure scalar_add_vec2(*res.vec2, s.f, *v1.vec2)
  *res\x = s + *v1\x
  *res\y = s + *v1\y
  ProcedureReturn *res
EndProcedure
Procedure scalar_sub_vec2(*res.vec2, s.f, *v1.vec2)
  *res\x = s - *v1\x
  *res\y = s - *v1\y
  ProcedureReturn *res
EndProcedure
Procedure scalar_mul_vec2(*res.vec2, s.f, *v1.vec2)
  *res\x = s * *v1\x 
  *res\y = s * *v1\y
  ProcedureReturn *res
EndProcedure
Procedure scalar_div_vec2(*res.vec2, s.f, *v1.vec2)
  *res\x = s / *v1\x
  *res\y = s / *v1\y
  ProcedureReturn *res
EndProcedure
Procedure.l vec2_isEqual(*v1.vec2, *v2.vec2)
  ProcedureReturn Bool(*v1\x = *v2\x And *v1\y = *v2\y)
EndProcedure
;-
Procedure vec3_set_float(*res.vec3, x.f=0.0, y.f=0.0, z.f=0.0)
  *res\x = x
  *res\y = y
  *res\z = z
  ProcedureReturn *res
EndProcedure
Procedure vec3_set_Scalar(*res.vec3, s.f)
  *res\x = s
  *res\y = s
  *res\z = s
  ProcedureReturn *res
EndProcedure
Procedure vec3_set_vec2(*res.vec3, *v.vec2, f.f)
  *res\x = *v\x
  *res\y = *v\y
  *res\z = f
  ProcedureReturn *res
EndProcedure
Procedure vec3_set(*res.vec3, *v.vec3)
  *res\x = *v\x
  *res\y = *v\y
  *res\z = *v\z
  ProcedureReturn *res
EndProcedure
Procedure vec3_set_vec4(*res.vec3, *v.vec4)
  *res\x = *v\x
  *res\y = *v\y
  *res\z = *v\z
  ProcedureReturn *res
EndProcedure
Procedure vec3_add(*res.vec3, *v1.vec3, *v2.vec3)
  *res\x = *v1\x + *v2\x
  *res\y = *v1\y + *v2\y
  *res\z = *v1\z + *v2\z
  ProcedureReturn *res
EndProcedure
Procedure vec3_sub(*res.vec3, *v1.vec3, *v2.vec3)
  *res\x = *v1\x - *v2\x
  *res\y = *v1\y - *v2\y
  *res\z = *v1\z - *v2\z
  ProcedureReturn *res
EndProcedure
Procedure vec3_mul(*res.vec3, *v1.vec3, *v2.vec3)
  *res\x = *v1\x * *v2\x
  *res\y = *v1\y * *v2\y
  *res\z = *v1\z * *v2\z
  ProcedureReturn *res
EndProcedure
Procedure vec3_div(*res.vec3, *v1.vec3, *v2.vec3)
  *res\x = *v1\x / *v2\x
  *res\y = *v1\y / *v2\y
  *res\z = *v1\z / *v2\z
  ProcedureReturn *res
EndProcedure
Procedure vec3_add_scalar(*res.vec3, *v1.vec3, s.f)
  *res\x = *v1\x + s
  *res\y = *v1\y + s
  *res\z = *v1\z + s
  ProcedureReturn *res
EndProcedure
Procedure vec3_sub_scalar(*res.vec3, *v1.vec3, s.f)
  *res\x = *v1\x - s
  *res\y = *v1\y - s
  *res\z = *v1\z - s
  ProcedureReturn *res
EndProcedure
Procedure vec3_mul_scalar(*res.vec3, *v1.vec3, s.f)
  *res\x = *v1\x * s
  *res\y = *v1\y * s
  *res\z = *v1\z * s
  ProcedureReturn *res
EndProcedure
Procedure vec3_div_scalar(*res.vec3, *v1.vec3, s.f)
  *res\x = *v1\x / s
  *res\y = *v1\y / s
  *res\z = *v1\z / s
  ProcedureReturn *res
EndProcedure
Procedure scalar_add_vec3(*res.vec3, s.f, *v1.vec3)
  *res\x = s + *v1\x
  *res\y = s + *v1\y
  *res\z = s + *v1\z 
  ProcedureReturn *res
EndProcedure
Procedure scalar_sub_vec3(*res.vec3, s.f, *v1.vec3)
  *res\x = s - *v1\x
  *res\y = s - *v1\y
  *res\z = s - *v1\z 
  ProcedureReturn *res
EndProcedure
Procedure scalar_mul_vec3(*res.vec3, s.f, *v1.vec3)
  *res\x = s * *v1\x 
  *res\y = s * *v1\y
  *res\z = s * *v1\z 
  ProcedureReturn *res
EndProcedure
Procedure scalar_div_vec3(*res.vec3, s.f, *v1.vec3)
  *res\x = s / *v1\x
  *res\y = s / *v1\y
  *res\z = s / *v1\z 
  ProcedureReturn *res
EndProcedure
Procedure.l vec3_isEqual(*v1.vec3, *v2.vec3)
  ProcedureReturn Bool(*v1\x = *v2\x And *v1\y = *v2\y And *v1\z = *v2\z)
EndProcedure
;-
Procedure vec4_set_float(*res.vec4, x.f=0.0, y.f=0.0, z.f=0.0, w.f=0.0)
  *res\x = x
  *res\y = y
  *res\z = z
  *res\w = w
  ProcedureReturn *res
EndProcedure
Procedure vec4_set_Scalar(*res.vec4, s.f)
  *res\x = s
  *res\y = s
  *res\z = s
  *res\w = s
  ProcedureReturn *res
EndProcedure
Procedure vec4_set_vec2(*res.vec4, *v1.vec2, *v2.vec2)
  *res\x = *v1\x
  *res\y = *v1\y
  *res\z = *v2\x
  *res\w = *v2\y
  ProcedureReturn *res
EndProcedure
Procedure vec4_set_vec3(*res.vec4, *v.vec3, f.f)
  *res\x = *v\x
  *res\y = *v\y
  *res\z = *v\z
  *res\w = f
  ProcedureReturn *res
EndProcedure
Procedure vec4_set(*res.vec4, *v.vec4)
  *res\x = *v\x
  *res\y = *v\y
  *res\z = *v\z
  *res\w = *v\w
  ProcedureReturn *res
EndProcedure
Procedure vec4_add(*res.vec4, *v1.vec4, *v2.vec4)
  *res\x = *v1\x + *v2\x
  *res\y = *v1\y + *v2\y
  *res\z = *v1\z + *v2\z
  *res\w = *v1\w + *v2\w
  ProcedureReturn *res
EndProcedure
Procedure vec4_sub(*res.vec4, *v1.vec4, *v2.vec4)
  *res\x = *v1\x - *v2\x
  *res\y = *v1\y - *v2\y
  *res\z = *v1\z - *v2\z
  *res\w = *v1\w - *v2\w
  ProcedureReturn *res
EndProcedure
Procedure vec4_mul(*res.vec4, *v1.vec4, *v2.vec4)
  *res\x = *v1\x * *v2\x
  *res\y = *v1\y * *v2\y
  *res\z = *v1\z * *v2\z
  *res\w = *v1\w * *v2\w
  ProcedureReturn *res
EndProcedure
Procedure vec4_div(*res.vec4, *v1.vec4, *v2.vec4)
  *res\x = *v1\x / *v2\x
  *res\y = *v1\y / *v2\y
  *res\z = *v1\z / *v2\z
  *res\w = *v1\w / *v2\w
  ProcedureReturn *res
EndProcedure
Procedure vec4_add_scalar(*res.vec4, *v1.vec4, s.f)
  *res\x = *v1\x + s
  *res\y = *v1\y + s
  *res\z = *v1\z + s
  *res\w = *v1\w + s
  ProcedureReturn *res
EndProcedure
Procedure vec4_sub_scalar(*res.vec4, *v1.vec4, s.f)
  *res\x = *v1\x - s
  *res\y = *v1\y - s
  *res\z = *v1\z - s
  *res\w = *v1\w - s
  ProcedureReturn *res
EndProcedure
Procedure vec4_mul_scalar(*res.vec4, *v1.vec4, s.f)
  *res\x = *v1\x * s
  *res\y = *v1\y * s
  *res\z = *v1\z * s
  *res\w = *v1\w * s
  ProcedureReturn *res
EndProcedure
Procedure vec4_div_scalar(*res.vec4, *v1.vec4, s.f)
  *res\x = *v1\x / s
  *res\y = *v1\y / s
  *res\z = *v1\z / s
  *res\w = *v1\w / s
  ProcedureReturn *res
EndProcedure
Procedure scalar_add_vec4(*res.vec4, s.f, *v1.vec4)
  *res\x = s + *v1\x
  *res\y = s + *v1\y
  *res\z = s + *v1\z 
  *res\w = s + *v1\w
  ProcedureReturn *res
EndProcedure
Procedure scalar_sub_vec4(*res.vec4, s.f, *v1.vec4)
  *res\x = s - *v1\x
  *res\y = s - *v1\y
  *res\z = s - *v1\z 
  *res\w = s - *v1\w
  ProcedureReturn *res
EndProcedure
Procedure scalar_mul_vec4(*res.vec4, s.f, *v1.vec4)
  *res\x = s * *v1\x 
  *res\y = s * *v1\y
  *res\z = s * *v1\z 
  *res\w = s * *v1\w
  ProcedureReturn *res
EndProcedure
Procedure scalar_div_vec4(*res.vec4, s.f, *v1.vec4)
  *res\x = s / *v1\x
  *res\y = s / *v1\y
  *res\z = s / *v1\z 
  *res\w = s / *v1\w
  ProcedureReturn *res
EndProcedure
Procedure.l vec4_isEqual(*v1.vec4, *v2.vec4)
  ProcedureReturn Bool(*v1\x = *v2\x And *v1\y = *v2\y And *v1\z = *v2\z And *v1\w = *v2\w)
EndProcedure
;}
;-----------------------
;- matrix_clip_space_inl.pbi
;{

UseModule math
Procedure ortho2(*res.mat4x4, left.f, right.f, bottom.f, top.f)
  Mat4x4_set_Scalar(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = - (1)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  ProcedureReturn *res
EndProcedure
Procedure orthoLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  Mat4x4_set_Scalar(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = (1) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - zNear / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure orthoLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  Mat4x4_set_Scalar(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = (2) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - (zFar + zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure orthoRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  Mat4x4_set_Scalar(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = - (1) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - zNear / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure orthoRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  Mat4x4_set_Scalar(*res,1)
  *res\v[0]\f[0] = (2) / (right - left)
  *res\v[1]\f[1] = (2) / (top - bottom)
  *res\v[2]\f[2] = - (2) / (zFar - zNear)
  *res\v[3]\f[0] = - (right + left) / (right - left)
  *res\v[3]\f[1] = - (top + bottom) / (top - bottom)
  *res\v[3]\f[2] = - (zFar + zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure orthoZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  ProcedureReturn orthoRH_ZO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure orthoNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  ProcedureReturn orthoRH_NO(*res.mat4x4, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure orthoLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  ProcedureReturn orthoLH_NO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure orthoRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  ProcedureReturn orthoRH_NO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure ortho(*res.mat4x4, left.f, right.f, bottom.f, top.f, zNear.f, zFar.f)
  ProcedureReturn orthoRH_NO(*res, left, right, bottom, top, zNear, zFar)
EndProcedure
Procedure frustumLH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = farVal / (farVal - nearVal)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = -(farVal * nearVal) / (farVal - nearVal)
  ProcedureReturn *res
EndProcedure
Procedure frustumLH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = (farVal + nearVal) / (farVal - nearVal)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - ((2) * farVal * nearVal) / (farVal - nearVal)
  ProcedureReturn *res
EndProcedure
Procedure frustumRH_ZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = farVal / (nearVal - farVal)
  *res\v[2]\f[3] = (-1)
  *res\v[3]\f[2] = -(farVal * nearVal) / (farVal - nearVal)
  ProcedureReturn *res
EndProcedure
Procedure frustumRH_NO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = ((2) * nearVal) / (right - left)
  *res\v[1]\f[1] = ((2) * nearVal) / (top - bottom)
  *res\v[2]\f[0] = (right + left) / (right - left)
  *res\v[2]\f[1] = (top + bottom) / (top - bottom)
  *res\v[2]\f[2] = - (farVal + nearVal) / (farVal - nearVal)
  *res\v[2]\f[3] = (-1)
  *res\v[3]\f[2] = - ((2) * farVal * nearVal) / (farVal - nearVal)
  ProcedureReturn *res
EndProcedure
Procedure frustumZO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  ProcedureReturn frustumRH_ZO(*res,left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustumNO(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  ProcedureReturn frustumRH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustumLH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  ProcedureReturn frustumLH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustumRH(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  ProcedureReturn frustumRH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure frustum(*res.mat4x4, left.f, right.f, bottom.f, top.f, nearVal.f, farVal.f)
  ProcedureReturn frustumRH_NO(*res, left, right, bottom, top, nearVal, farVal)
EndProcedure
Procedure perspectiveRH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected.f tanHalfFovy = _math_::Tan(fovy / 2)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = zFar / (zNear - zFar)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveRH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected.f tanHalfFovy = _math_::Tan(fovy / 2)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = - (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res  
EndProcedure
Procedure perspectiveLH_ZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected.f tanHalfFovy = _math_::Tan(fovy / 2)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = zFar / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveLH_NO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  _math::assert( _math_::Abs(aspect - #epsilon) > 0 )
  Protected tanHalfFovy = _math_::Tan(fovy / 2)
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = (1) / (aspect * tanHalfFovy)
  *res\v[1]\f[1] = (1) / (tanHalfFovy)
  *res\v[2]\f[2] = (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveZO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveRH_ZO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspectiveNO(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveRH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveLH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure      
Procedure perspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveRH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveRH_NO(*res, fovy, aspect, zNear, zFar)
EndProcedure
Procedure perspectiveFovRH_ZO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;///todo max(width , Height) / min(width , Height)?
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = zFar / (zNear - zFar)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveFovRH_NO(*res.mat4x4, fov.f, width.f, height.f, zNear.f, zFar.f)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;todo max(width , Height) / min(width , Height)?
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = - (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveFovLH_ZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;todo max(width , Height) / min(width , Height)?
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = zFar / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = -(zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveFovLH_NO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  _math::assert(width > 0)
	_math::assert(height > 0)
	_math::assert(fov > 0)
  Protected.f rad = fov
  Protected.f h = _math_::Cos((0.5) * rad) / _math_::Sin((0.5) * rad)
  Protected.f w = h * height / width ;todo max(width , Height) / min(width , Height)?
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = w
  *res\v[1]\f[1] = h
  *res\v[2]\f[2] = (zFar + zNear) / (zFar - zNear)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - ((2) * zFar * zNear) / (zFar - zNear)
  ProcedureReturn *res
EndProcedure
Procedure perspectiveFovZO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveFovRH_ZO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFovNO(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveFovRH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFovLH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveFovLH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFovRH(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveFovRH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure perspectiveFov(*res.mat4x4, fov.f, width.f,height.f, zNear.f, zFar.f)
  ProcedureReturn perspectiveFovRH_NO(*res, fov, width, height, zNear, zFar)
EndProcedure
Procedure infinitePerspectiveRH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
  Protected.f range = _math_::Tan(fovy / 2) * zNear
  Protected.f left = -range * aspect
  Protected.f right = range * aspect
  Protected.f bottom = -range
  Protected.f top = range
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = ((2) * zNear) / (right - left)
  *res\v[1]\f[1] = ((2) * zNear) / (top - bottom)
  *res\v[2]\f[2] = - (1)
  *res\v[2]\f[3] = - (1)
  *res\v[3]\f[2] = - (2) * zNear
  ProcedureReturn *res
EndProcedure
Procedure infinitePerspectiveLH(*res.mat4x4, fovy.f, aspect.f, zNear.f)
  Protected.f range = _math_::Tan(fovy / 2) * zNear
  Protected.f left = -range * aspect
  Protected.f right = range * aspect
  Protected.f bottom = -range
  Protected.f top = range
  Mat4x4_set_Scalar(*res,0)
  *res\v[0]\f[0] = ((2) * zNear) / (right - left)
  *res\v[1]\f[1] = ((2) * zNear) / (top - bottom)
  *res\v[2]\f[2] = (1)
  *res\v[2]\f[3] = (1)
  *res\v[3]\f[2] = - (2) * zNear
  ProcedureReturn *res
EndProcedure
Procedure infinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f)
  ProcedureReturn infinitePerspectiveRH(*res, fovy, aspect, zNear)
EndProcedure
; Infinite projection matrix: http://www.terathon.com/gdc07_lengyel.pdf
Procedure tweakedInfinitePerspective(*res.mat4x4, fovy.f, aspect.f, zNear.f, ep.f=#epsilon)
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
  ProcedureReturn *res
EndProcedure
;}
;-----------------------
;- matrix_projection_inl.pbi
;{

Procedure projectZO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  mul(tmp, *model, tmp)
  mul(tmp, *proj, tmp)
  vec4_div_scalar(tmp, tmp, tmp\w)
  tmp\x = tmp\x * 0.5 + 0.5
  tmp\y = tmp\y * 0.5 + 0.5
  tmp\f[0] = tmp\f[0] * *viewport\f[2] + *viewport\f[0]
  tmp\f[1] = tmp\f[1] * *viewport\f[3] + *viewport\f[1]
  set(*res, tmp)
  ProcedureReturn *res
EndProcedure
Procedure projectNO(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  mul(tmp, *model, tmp)
  mul(tmp, *proj, tmp)
  vec4_div_scalar(tmp, tmp, tmp\w)
  vec4_mul_scalar(tmp, tmp, 0.5)
  vec4_add_scalar(tmp, tmp, tmp\w)
  tmp\f[0] = tmp\f[0] * *viewport\f[2] + *viewport\f[0]
  tmp\f[1] = tmp\f[1] * *viewport\f[3] + *viewport\f[1]
  set(*res, tmp)
  ProcedureReturn *res
EndProcedure
Procedure project(*res.vec3, *obj.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
  ProcedureReturn projectNO(*res, *obj, *model, *proj, *viewport)
EndProcedure
Procedure unProjectZO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)	
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
  vec4_div_scalar(obj, obj, obj\w)
  set(*res, obj)
  ProcedureReturn *res
EndProcedure
Procedure unProjectNO(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
  Protected.mat4x4 Inverse 
  mul(Inverse, *proj, *model)
  inverse(Inverse, Inverse)
  Protected.vec4 tmp 
  set_float(tmp, 1)
  tmp\x = (tmp\x - *viewport\f[0]) / *viewport\f[2]
  tmp\y = (tmp\y - *viewport\f[1]) / *viewport\f[3]
  vec4_mul_Scalar(tmp, tmp, 2)
  vec4_sub_Scalar(tmp, tmp, 1)
  Protected.vec4 obj
  mul(obj, Inverse, tmp)
  vec4_div_scalar(obj, obj, obj\w)
  set(*res, obj)
  ProcedureReturn *res
EndProcedure
Procedure unProject(*res.vec3, *win.vec3, *model.mat4x4, *proj.mat4x4, *viewport.vec4)
  ProcedureReturn unProjectNO(*res, *win, *model, *proj, *viewport)
EndProcedure
Procedure pickMatrix(*res.mat4x4, *center.vec2, *delta.vec2, *viewport.vec4)
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
  ProcedureReturn *res  
EndProcedure
;}
;-----------------------
;- matrix_transform_inl.pbi
;{

Procedure translate(*res.mat4x4, *m.mat4x4, *v.vec3)
  set(*res, *m)
  Protected.vec4 tmp,result
  ;Result[3] = m[0] * v[0] + m[1] * v[1] + m[2] * v[2] + m[3]
  vec4_mul_Scalar(result, *m\v[0], *v\f[0])
  vec4_mul_Scalar(tmp,    *m\v[1], *v\f[1])
  vec4_add(result,        result , tmp)
  vec4_mul_Scalar(tmp,    *m\v[2], *v\f[2])
  vec4_add(result,        result , tmp)
  vec4_add(result,        result , *m\v[3])
  vec4_set(*res\v[3], result)
  ProcedureReturn *res
EndProcedure
Procedure translate_float(*res.mat4x4, *m.mat4x4, x.f,y.f,z.f)
  set(*res, *m)
  Protected.vec4 tmp,result
  ;Result[3] = m[0] * v[0] + m[1] * v[1] + m[2] * v[2] + m[3]
  vec4_mul_Scalar(result, *m\v[0], x)
  vec4_mul_Scalar(tmp,    *m\v[1], y)
  vec4_add(result,        result , tmp)
  vec4_mul_Scalar(tmp,    *m\v[2], z)
  vec4_add(result,        result , tmp)
  vec4_add(result,        result , *m\v[3])
  vec4_set(*res\v[3], result)
  ProcedureReturn *res
EndProcedure
Procedure rotate(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
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
  Scalar_mul_vec3(temp, 1-c, axis)
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
  vec4_mul_Scalar( *res\v[0], *m\v[0]   , Rotate\v[0]\f[0])
  vec4_mul_Scalar( tmp      , *m\v[1]   , Rotate\v[0]\f[1])
  vec4_add(        *res\v[0], *res\v[0] , tmp)
  vec4_mul_Scalar( tmp      , *m\v[2]   , Rotate\v[0]\f[2])
  vec4_add(        *res\v[0], *res\v[0] , tmp)
  ;Result[1] = m[0] * Rotate[1][0] + m[1] * Rotate[1][1] + m[2] * Rotate[1][2];
  vec4_mul_Scalar( *res\v[1], *m\v[0]   , Rotate\v[1]\f[0])
  vec4_mul_Scalar( tmp      , *m\v[1]   , Rotate\v[1]\f[1])
  vec4_add(        *res\v[1], *res\v[1] , tmp)
  vec4_mul_Scalar( tmp      , *m\v[2]   , Rotate\v[1]\f[2])
  vec4_add(        *res\v[1], *res\v[1] , tmp)
  ;Result[2] = m[0] * Rotate[2][0] + m[1] * Rotate[2][1] + m[2] * Rotate[2][2];
  vec4_mul_Scalar( *res\v[2], *m\v[0]   , Rotate\v[2]\f[0])
  vec4_mul_Scalar( tmp      , *m\v[1]   , Rotate\v[2]\f[1])
  vec4_add(        *res\v[2], *res\v[2] , tmp)
  vec4_mul_Scalar( tmp      , *m\v[2]   , Rotate\v[2]\f[2])
  vec4_add(        *res\v[2], *res\v[2] , tmp)
  ;Result[3] = m[3];
  vec4_set(   *res\v[3], *m\v[3])
  ProcedureReturn *res
EndProcedure
Procedure rotate_float(*res.mat4x4, *m.mat4x4, angle.f, x.f,y.f,z.f)
  If *res = *m
    Protected.mat4x4 tmpM
    set(tmpM, *m)
    *m = @tmpM
  EndIf
  Protected.f c = _math_::Cos(angle)
  Protected.f s = _math_::Sin(angle)
  Protected.vec3 axis
  vec3_set_float(axis, x,y,z)
  normalize(axis, axis)
  Protected.vec3 temp
  scalar_mul_vec3(temp, 1-c, axis)
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
  vec4_mul_Scalar( *res\v[0], *m\v[0]   , Rotate\v[0]\f[0])
  vec4_mul_Scalar( tmp      , *m\v[1]   , Rotate\v[0]\f[1])
  vec4_add(        *res\v[0], *res\v[0] , tmp)
  vec4_mul_Scalar( tmp      , *m\v[2]   , Rotate\v[0]\f[2])
  vec4_add(        *res\v[0], *res\v[0] , tmp)
  ;Result[1] = m[0] * Rotate[1][0] + m[1] * Rotate[1][1] + m[2] * Rotate[1][2];
  vec4_mul_Scalar( *res\v[1], *m\v[0]   , Rotate\v[1]\f[0])
  vec4_mul_Scalar( tmp      , *m\v[1]   , Rotate\v[1]\f[1])
  vec4_add(        *res\v[1], *res\v[1] , tmp)
  vec4_mul_Scalar( tmp      , *m\v[2]   , Rotate\v[1]\f[2])
  vec4_add(        *res\v[1], *res\v[1] , tmp)
  ;Result[2] = m[0] * Rotate[2][0] + m[1] * Rotate[2][1] + m[2] * Rotate[2][2];
  vec4_mul_Scalar( *res\v[2], *m\v[0]   , Rotate\v[2]\f[0])
  vec4_mul_Scalar( tmp      , *m\v[1]   , Rotate\v[2]\f[1])
  vec4_add(        *res\v[2], *res\v[2] , tmp)
  vec4_mul_Scalar( tmp      , *m\v[2]   , Rotate\v[2]\f[2])
  vec4_add(        *res\v[2], *res\v[2] , tmp)
  ;Result[3] = m[3];
  vec4_set(   *res\v[3], *m\v[3])
  ProcedureReturn *res
EndProcedure
Procedure rotate_slow(*res.mat4x4, *m.mat4x4, angle.f, *v.vec3)
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
  ProcedureReturn *res
EndProcedure
Procedure rotate_slow_float(*res.mat4x4, *m.mat4x4, angle.f, x.f,y.f,z.f)
  Protected.f a = angle
  Protected.f c = _math_::Cos(a)
  Protected.f s = _math_::Sin(a)
  Protected.vec3 axis
  vec3_set_float(axis, x,y,z)
  normalize(axis, axis)
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
  ProcedureReturn *res
EndProcedure
Procedure scale(*res.mat4x4, *m.mat4x4, *v.vec3)
  vec4_mul_Scalar(*res\v[0], *m\v[0], *v\f[0])
  vec4_mul_Scalar(*res\v[1], *m\v[1], *v\f[1])
  vec4_mul_Scalar(*res\v[2], *m\v[2], *v\f[2])
  vec4_set  (*res\v[3], *m\v[3])
  ProcedureReturn *res
EndProcedure
Procedure scale_float(*res.mat4x4, *m.mat4x4, x.f,y.f,z.f)
  vec4_mul_Scalar(*res\v[0], *m\v[0], x)
  vec4_mul_Scalar(*res\v[1], *m\v[1], y)
  vec4_mul_Scalar(*res\v[2], *m\v[2], z)
  vec4_set  (*res\v[3], *m\v[3])
  ProcedureReturn *res
EndProcedure
Procedure scale_slow(*res.mat4x4, *m.mat4x4, *v.vec3)
  Protected.mat4x4 Result
  set_float(Result, 1)
  Result\v[0]\f[0] = *v\x
  Result\v[1]\f[1] = *v\y
  Result\v[2]\f[2] = *v\z
  mul(*res, *m, Result)
  ProcedureReturn *res
EndProcedure
Procedure scale_slow_float(*res.mat4x4, *m.mat4x4, x.f,y.f,z.f)
  Protected.mat4x4 Result
  set_float(Result, 1)
  Result\v[0]\f[0] = x
  Result\v[1]\f[1] = y
  Result\v[2]\f[2] = z
  mul(*res, *m, Result)
  ProcedureReturn *res
EndProcedure
Procedure lookAtRH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
  Protected.vec3 f
  sub(f, *center, *eye)
  normalize(f,f)
  Protected.vec3 s
  vec3_cross(s, f, *up)
  normalize(s,s)	  
  Protected.vec3 u
  vec3_cross(u, s, f)
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
  ProcedureReturn *res
EndProcedure
Procedure lookAtLH(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
  Protected.vec3 f
  sub(f, *center, *eye)
  normalize(f,f)	  
  Protected.vec3 s
  vec3_cross(s, *up, f)
  normalize(s, s)
  Protected.vec3 u
  vec3_cross(u, f, s)	  
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
  ProcedureReturn *res
EndProcedure
Procedure lookAt(*res.mat4x4, *eye.vec3, *center.vec3, *up.vec3)
  ProcedureReturn lookAtRH(*res, *eye, *center, *up)  
EndProcedure
;}
;-----------------------
;- type_quat_inl.pbi
;{

UseModule math
Procedure quat_set_float(*res.quat, w.f=1.0, x.f=0.0, y.f=0.0, z.f=0.0)
  *res\x = x
  *res\y = y
  *res\z = z
  *res\w = w
  ProcedureReturn *res
EndProcedure
Procedure quat_set_Scalar(*res.quat, s.f)
  *res\w = (s)
  *res\x = (s)
  *res\y = (s)
  *res\z = (s)  
ProcedureReturn *res
EndProcedure
Procedure quat_set(*res.quat, *q.quat)
  *res\w = *q\w
  *res\x = *q\x
  *res\y = *q\y
  *res\z = *q\z  
ProcedureReturn *res
EndProcedure
Procedure quat_set_f_vec3(*res.quat,s.f,*v.vec3)
  *res\w = s
  *res\x = *v\x
  *res\y = *v\y
  *res\z = *v\z
ProcedureReturn *res
EndProcedure
Procedure Quat_set_vec3_vec3(*res.quat, *u.vec3, *v.vec3)
  Protected.f norm_u_norm_v = Sqr(vec3_dot(*u, *u) * vec3_dot(*v, *v))
  Protected.f real_part = norm_u_norm_v + vec3_dot(*u, *v)
  Protected.vec3 t
  If real_part < 1.e-6 * norm_u_norm_v
    ; If u And v are exactly opposite, rotate 180 degrees
    ; around an arbitrary orthogonal axis. Axis normalisation
    ; can happen later, when we normalise the quaternion.
    real_part = 0
    If _math_::Abs(*u\x) > _math_::Abs(*u\z)
      vec3_set_float(t, -*u\y, *u\x, 0) 
    Else
      vec3_set_float(t, 0, -*u\z, *u\y)
    EndIf
  Else
    ; Otherwise, build quaternion the standard way.
    vec3_cross(t, *u, *v)
  EndIf
  quat_set_float(*res, real_part, t\x, t\y, t\z)
  quat_normalize(*res, *res)
  ProcedureReturn *res
EndProcedure
Procedure quat_set_eulerAngle(*res.quat, *eulerAngle.vec3)
  Protected.vec3 c,s
  vec3_mul_scalar(c, *eulerAngle, 0.5)
  vec3_mul_scalar(s, *eulerAngle, 0.5)
  Cos(c, c)
  Sin(s, s)
  *res\w = c\x * c\y * c\z + s\x * s\y * s\z
  *res\x = s\x * c\y * c\z - c\x * s\y * s\z
  *res\y = c\x * s\y * c\z + s\x * c\y * s\z
  *res\z = c\x * c\y * s\z - s\x * s\y * c\z
  ProcedureReturn *res
EndProcedure
Procedure quat_set_mat3x3(*res.quat, *m.mat3x3)
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
      quat_set_float(*res, biggestVal, (*m\v[1]\f[2] - *m\v[2]\f[1]) * mult, (*m\v[2]\f[0] - *m\v[0]\f[2]) * mult, (*m\v[0]\f[1] - *m\v[1]\f[0]) * mult)
      ProcedureReturn
    Case 1
      quat_set_float(*res, (*m\v[1]\f[2] - *m\v[2]\f[1]) * mult, biggestVal, (*m\v[0]\f[1] + *m\v[1]\f[0]) * mult, (*m\v[2]\f[0] + *m\v[0]\f[2]) * mult)
      ProcedureReturn
    Case 2
      quat_set_float(*res, (*m\v[2]\f[0] - *m\v[0]\f[2]) * mult, (*m\v[0]\f[1] + *m\v[1]\f[0]) * mult, biggestVal, (*m\v[1]\f[2] + *m\v[2]\f[1]) * mult)
      ProcedureReturn
    Case 3:
      quat_set_float(*res, (*m\v[0]\f[1] - *m\v[1]\f[0]) * mult, (*m\v[2]\f[0] + *m\v[0]\f[2]) * mult, (*m\v[1]\f[2] + *m\v[2]\f[1]) * mult, biggestVal)
      ProcedureReturn
    Default ; Silence a -Wswitch-Default warning in GCC. Should never actually get here. Assert is just For sanity.
      _math::assert(#False)
      quat_set_float(*res, 1, 0, 0, 0)
      ProcedureReturn
  EndSelect
  ProcedureReturn *res
EndProcedure
Procedure quat_set_mat4x4(*res.quat, *m.mat4x4)
  Protected.mat3x3 x
  mat3x3_set_mat4x4(x, *m)
  quat_set_mat3x3(*res, x)
  ProcedureReturn *res
EndProcedure
Procedure mat3x3_set_quat(*res.mat3x3, *q.quat)
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
  ProcedureReturn *res
EndProcedure
Procedure mat4x4_set_quat(*res.mat4x4, *q.quat)
  Protected.mat3x3 m
  mat3x3_set_quat(m, *q)
  mat4x4_set_mat3x3(*res, m)
  ProcedureReturn *res
EndProcedure
Procedure quat_mul(*res.quat, *q.quat, *p.quat)
  If *res=*q
    Protected.quat tmp
    set(tmp, *q)
    *q=@tmp
  EndIf
  *res\w = *p\w * *q\w - *p\x * *q\x - *p\y * *q\y - *p\z * *q\z;
	*res\x = *p\w * *q\x + *p\x * *q\w + *p\y * *q\z - *p\z * *q\y;
	*res\y = *p\w * *q\y + *p\y * *q\w + *p\z * *q\x - *p\x * *q\z;
	*res\z = *p\w * *q\z + *p\z * *q\w + *p\x * *q\y - *p\y * *q\x;
	ProcedureReturn *res
EndProcedure
Procedure quat_mul_vec3(*res.vec3, *q.quat, *v.vec3)
  Protected.vec3 quatVector, uv, uuv
  vec3_set_float(quatVector, *q\x, *q\y, *q\z)
  Vec3_Cross(uv, quatVector, *v)
  Vec3_Cross(uuv, quatVector, uv)
  ;return v + ((uv * q.w) + uuv) * static_cast<T>(2);
  vec3_mul_scalar(uv, uv, *q\w)
  vec3_add(uv, uv, uuv)
  vec3_mul_Scalar(uv, uv, 2)
  vec3_add(*res, *v, uv)
  ProcedureReturn *res
EndProcedure
Procedure vec3_mul_quat(*res.vec3, *v.vec3, *q.quat)
  Protected.quat inv
  quat_inverse(inv, *q)
  quat_mul_vec3(*res, inv, *v)
  ProcedureReturn *res
EndProcedure
Procedure quat_mul_vec4(*res.vec4, *q.quat, *v.vec4)
  Protected.vec3 v
  vec3_set_vec4(v, *v)
  quat_mul_vec3(v, *q, v)
  vec4_set_vec3(*res, v, *v\w)
  ProcedureReturn *res
EndProcedure
Procedure vec4_mul_quat(*res.vec4, *v.vec4, *q.quat)
  Protected.quat inv
  quat_inverse(inv, *q)
  quat_mul_vec4(*res, inv, *v)
  ProcedureReturn *res
EndProcedure
Procedure quat_add_Scalar(*res.quat, *q.quat, s.f)
  *res\w = *q\w + s
  *res\x = *q\x + s
  *res\y = *q\y + s
  *res\z = *q\z + s  
  ProcedureReturn *res
EndProcedure
Procedure quat_sub_Scalar(*res.quat, *q.quat, s.f)
  *res\w = *q\w - s
  *res\x = *q\x - s
  *res\y = *q\y - s
  *res\z = *q\z - s  
  ProcedureReturn *res
EndProcedure
Procedure quat_mul_Scalar(*res.quat, *q.quat, s.f)
  *res\w = *q\w * s
  *res\x = *q\x * s
  *res\y = *q\y * s
  *res\z = *q\z * s  
  ProcedureReturn *res
EndProcedure
Procedure quat_div_Scalar(*res.quat, *q.quat, s.f)
  *res\w = *q\w / s
  *res\x = *q\x / s
  *res\y = *q\y / s
  *res\z = *q\z / s  
  ProcedureReturn *res
EndProcedure
Procedure Scalar_add_quat(*res.quat, s.f, *q.quat)
  *res\w = s + *q\w 
  *res\x = s + *q\x 
  *res\y = s + *q\y 
  *res\z = s + *q\z 
  ProcedureReturn *res
EndProcedure
Procedure Scalar_sub_quat(*res.quat, s.f, *q.quat)
  *res\w = s - *q\w 
  *res\x = s - *q\x 
  *res\y = s - *q\y 
  *res\z = s - *q\z 
  ProcedureReturn *res
EndProcedure
Procedure Scalar_mul_quat(*res.quat, s.f, *q.quat)
  *res\w = s * *q\w 
  *res\x = s * *q\x 
  *res\y = s * *q\y 
  *res\z = s * *q\z 
  ProcedureReturn *res
EndProcedure
Procedure Scalar_div_quat(*res.quat, s.f, *q.quat)
  *res\w = s / *q\w 
  *res\x = s / *q\x 
  *res\y = s / *q\y 
  *res\z = s / *q\z 
  ProcedureReturn *res
EndProcedure
Procedure quat_add(*res.quat, *q.quat, *p.quat)
  *res\w = *q\w + *p\w
  *res\x = *q\x + *p\x
  *res\y = *q\y + *p\y
  *res\z = *q\z + *p\z
  ProcedureReturn *res
EndProcedure
Procedure quat_sub(*res.quat, *q.quat, *p.quat)
  *res\w = *q\w - *p\w
  *res\x = *q\x - *p\x
  *res\y = *q\y - *p\y
  *res\z = *q\z - *p\z
  ProcedureReturn *res
EndProcedure
Procedure quat_isEqual(*q.quat, *p.quat)
  ProcedureReturn Bool(*q\w=*p\w And *q\x=*p\x And *q\y=*p\y And *q\z=*p\z)
EndProcedure
;}
;-----------------------
;- quaternion_common_inl.pbi
;{

Procedure quat_mix(*res.quat, *x.quat, *y.quat, a.f)
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
    Scalar_mul_quat(tmp, s, *x)
    s = _math_::Sin(a*angle)
    Scalar_mul_quat(*res, s,*y)
    add(*res, tmp, *res)
    s = _math_::Sin(angle)
    quat_div_Scalar(*res, *res, s)
    ProcedureReturn
  EndIf
  ProcedureReturn *res
EndProcedure
Procedure quat_lerp(*res.quat, *x.quat, *y.quat, a.f)
  ; Lerp is only defined in [0, 1]
  _math::assert(a >= 0 And a <= 1)
  Protected.quat tmp
  Scalar_mul_quat(tmp, 1-a, *x)
  Scalar_mul_quat(*res, a, *y)
  add(*res, tmp, *res)
  ProcedureReturn *res
EndProcedure
Procedure quat_slerp(*res.quat, *x.quat, *y.quat, a.f, k.f = 0)
  Protected.quat z
  Protected.f cosTheta = dot(*x, *y)
  ; If cosTheta < 0, the interpolation will take the long way around the sphere.
  ; To fix this, one quat must be negated.
  If cosTheta < 0
    Scalar_sub_quat(z, 0,*y)
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
    Scalar_mul_quat(tmp, s, *x)
    s = _math_::Sin(a*phi)
    scalar_mul_quat(*res, s, z)
    add(*res, tmp, *res)
    s = _math_::Sin(angle)
    quat_div_Scalar(*res, *res, s)
    ProcedureReturn
  EndIf
  ProcedureReturn *res
EndProcedure
Procedure quat_inverse(*res.quat, *q.quat)
  Protected.f dot = dot(*q, *q)
  quat_conjugate(*q, *q)
  quat_div_Scalar(*res, *q, dot)
  ProcedureReturn *res
EndProcedure
Procedure quat_conjugate(*res.quat, *q.quat)
  *res\w = *q\w
  *res\x = -*q\x
  *res\y = -*q\y
  *res\z = -*q\z
  ProcedureReturn *res
EndProcedure
;}
;-----------------------
;- quaternion_geometric_inl.pbi
;{

Procedure quat_normalize(*res.quat, *q.quat)
  Protected.f len = length(*q)
  If len <= 0
    set_float(*res, 1,0,0,0)
    ProcedureReturn 
  EndIf
  Protected.f oneOverLen = 1 / len
  set_float(*res, *q\w * oneOverLen, *q\x * oneOverLen, *q\y * oneOverLen, *q\z * oneOverLen)
  ProcedureReturn *res
EndProcedure
Procedure quat_cross(*res.quat, *q1.quat, *q2.quat)
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
  ProcedureReturn *res
EndProcedure
;}
;-----------------------
;- quaternion_exponential_inl.pbi
;{

Procedure quat_exp(*res.quat, *q.quat)
  Protected.vec3 u,v
  set_float(u, *q\x, *q\y, *q\z)
  Protected.f angle = Length(u)
  If angle < #epsilon
    quat_set_float(*res)
    ProcedureReturn
  EndIf
  vec3_div_Scalar(v, u, angle)
  Protected.f s = _math_::Sin(angle)
  scalar_mul_vec3(v, s, v)
  quat_set_f_vec3(*res, _math_::Cos(angle), v)
  ProcedureReturn *res
EndProcedure
Procedure quat_Log(*res.quat, *q.quat)
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
  ProcedureReturn *res  
EndProcedure
Procedure quat_pow(*res.quat, *x.quat, y.f)
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
  ProcedureReturn *res
EndProcedure
Procedure quat_sqrt(*res.quat, *q.quat)
  ProcedureReturn quat_pow(*res, *q, 0.5)
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
  ProcedureReturn *res
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
  Protected.f  tmp1 = 1 - *x\w * *x\w
  If tmp1 <= 0
    set_float(*res,0,0,1)
    ProcedureReturn
  EndIf
  Protected.f tmp2 = 1 / Sqr(tmp1)
  set_float(*res, *x\x * tmp2, *x\y * tmp2, *x\z * tmp2)
  ProcedureReturn *res
EndProcedure
Procedure angleAxis(*res.quat, angle.f, *v.vec3)
  Protected.f s = _math_::Sin(angle * 0.5)
  Protected.vec3 v
  vec3_mul_Scalar(v, *v, s)
  quat_set_f_vec3(*res,_math_::Cos(angle * 0.5), v )
  ProcedureReturn *res
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

Procedure quat_eulerAngles(*res.vec3, *x.quat)
  *res\x = math::quat_Pitch(*x)
  *res\y = math::quat_Yaw(*x)
  *res\z = math::quat_Roll(*x)
  ProcedureReturn *res
EndProcedure
Procedure quat_LookAt(*res.quat, *direction.vec3, *up.vec3)
	ProcedureReturn quat_LookAtRH(*res, *direction, *up)
EndProcedure
Procedure quat_LookAtRH(*res.quat, *direction.vec3, *up.vec3)
  Protected.mat3x3 result
  Protected.vec3 right
  mat3x3_set_scalar(result,1)
  Scalar_sub_vec3( Result\v[2], 0, *direction)
  Vec3_Cross(right, *up, result\v[2])
  Protected.f s = inversesqrt_f(max_f(0.00001, dot(Right, Right)))
  vec3_mul_Scalar( Result\v[0], right, s)
  Vec3_Cross(result\v[1], result\v[2], result\v[0])
  set(*res, Result)
  ProcedureReturn *res
EndProcedure
Procedure quat_LookAtLH(*res.quat, *direction.vec3, *up.vec3)
	Protected.mat3x3 result
  Protected.vec3 right
  mat3x3_set_scalar(result,1)
  vec3_set( Result\v[2], *direction)
  Vec3_Cross(right, *up, result\v[2])
	Protected.f s = inversesqrt_f(max_f(0.00001, dot(Right, Right)))
  vec3_mul_Scalar( Result\v[0], right, s)
	Vec3_Cross(result\v[1], result\v[2], result\v[0])
	set(*res, Result)
	ProcedureReturn *res
EndProcedure
Procedure.f quat_Roll(*q.math::quat)
  Protected.f y = 2 * (*q\x * *q\y + *q\w * *q\z)
	Protected.f x = *q\w * *q\w + *q\x * *q\x - *q\y * *q\y - *q\z * *q\z
	
	If math::equal_f(x,0) And math::equal_f(y,0)
	  ProcedureReturn 0
	EndIf
	
	ProcedureReturn _math_::ATan2(y, x)
EndProcedure
Procedure.f quat_Pitch(*q.math::quat)
		;//Return T(ATan(T(2) * (q.y * q.z + q.w * q.x), q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z));
		Protected.f y = 2 * (*q\y * *q\z + *q\w * *q\x)
		Protected.f x = *q\w * *q\w - *q\x * *q\x - *q\y * *q\y + *q\z * *q\z
		
		If math::equal_f(x,0) And math::equal_f(y,0)
		  ProcedureReturn 0
		EndIf
		
		ProcedureReturn _math_::ATan2(y,x)
EndProcedure		
Procedure.f quat_Yaw(*q.math::quat)
	ProcedureReturn _math_::ASin(math::clamp_f(-2 * (*q\x * *q\z - *q\w * *q\y), -1, 1))
EndProcedure
;}
;-----------------------
;- euler_angles_inl.pbi
;{

Procedure eulerAngleX(*res.mat4x4, angleX.f)
  Protected.f cosX = _math_::Cos(angleX)
  Protected.f sinX = _math_::Sin(angleX)
  set_float(*res,
            1, 0, 0, 0,
            0, cosX, sinX, 0,
            0,-sinX, cosX, 0,
            0, 0, 0, 1)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleY(*res.mat4x4, angleY.f)
  Protected.f cosY = _math_::Cos(angleY)
  Protected.f sinY = _math_::Sin(angleY)
  set_float(*res,
            cosY,  0,  -sinY,  0,
            0,  1,  0,  0,
            sinY,  0,  cosY,  0,
            0,  0,  0,  1)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZ(*res.mat4x4, angleZ.f)
  Protected.f cosZ = _math_::Cos(angleZ)
  Protected.f sinZ = _math_::Sin(angleZ)
  set_float(*res,
            cosZ,  sinZ,  0, 0,
            -sinZ,  cosZ,  0, 0,
            0,  0,  1, 0,
            0,  0,  0, 1)
  ProcedureReturn *res
EndProcedure
Procedure derivedEulerAngleX(*res.mat4x4, angleX.f, angularVelocityX.f)
  Protected.f cosX = _math_::Cos(angleX) * angularVelocityX 
  Protected.f sinX = _math_::Sin(angleX) * angularVelocityX 
  set_float(*res,
            0, 0, 0, 0,
            0,-sinX, cosX, 0,
            0,-cosX,-sinX, 0,
            0, 0, 0, 0)
  ProcedureReturn *res
EndProcedure
Procedure derivedEulerAngleY(*res.mat4x4, angleY.f, angularVelocityY.f)
  Protected.f cosY = _math_::Cos(angleY) * angularVelocityY
  Protected.f sinY = _math_::Sin(angleY) * angularVelocityY
  set_float(*res,
            -sinY, 0, -cosY, 0,
            0   , 0,  0   , 0,
            cosY, 0, -sinY, 0,
            0   , 0,  0   , 0)
  ProcedureReturn *res
EndProcedure
Procedure derivedEulerAngleZ(*res.mat4x4, angleZ.f, angularVelocityZ.f)
  Protected.f cosZ = _math_::Cos(angleZ) * angularVelocityZ
  Protected.f sinZ = _math_::Sin(angleZ) * angularVelocityZ
  set_float(*res,
            -sinZ,  cosZ, 0, 0,
            -cosZ, -sinZ, 0, 0,
            0   ,  0   , 0, 0,
            0   ,  0   , 0, 0)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleXY(*res.mat4x4, angleX.f, angleY.f)
  Protected.f cosX = _math_::Cos(angleX)
  Protected.f sinX = _math_::Sin(angleX)
  Protected.f cosY = _math_::Cos(angleY)
  Protected.f sinY = _math_::Sin(angleY)
  set_float(*res,
            cosY, (-sinX) * (-sinY),  cosX * (-sinY), 0,
            0   ,              cosX,          sinX  , 0,
            sinY, (-sinX) *  cosY  ,  cosX *  cosY  , 0,
            0   ,                 0,               0, 1)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleYX(*res.mat4x4, angleY.f, angleX.f)
  Protected.f cosX = _math_::Cos(angleX)
  Protected.f sinX = _math_::Sin(angleX)
  Protected.f cosY = _math_::Cos(angleY)
  Protected.f sinY = _math_::Sin(angleY)
  set_float(*res,
            cosY       ,     0,       -sinY, 0,
            sinY * sinX,  cosX, cosY * sinX, 0,
            sinY * cosX, -sinX, cosY * cosX, 0,
            0          ,     0,           0, 1)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleXZ(*res.mat4x4, angleX.f, angleZ.f)
  Protected.mat4x4 tmp1, tmp2
  eulerAngleX(tmp1, angleX) 
  eulerAngleZ(tmp2, angleZ)
  mul(*res, tmp1, tmp2)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZX(*res.mat4x4, angleZ.f, angleX.f)
  Protected.mat4x4 tmp1, tmp2
  eulerAngleZ(tmp1,angleZ) 
  eulerAngleX(tmp2,angleX)
  mul(*res, tmp1, tmp2)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleYZ(*res.mat4x4, angleY.f, angleZ.f)
  Protected.mat4x4 tmp1, tmp2
  eulerAngleY(tmp1, angleY) 
  eulerAngleZ(tmp2, angleZ)
  mul(*res, tmp1, tmp2)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZY(*res.mat4x4, angleZ.f, angleY.f)
  Protected.mat4x4 tmp1, tmp2
  eulerAngleZ(tmp1, angleZ) 
  eulerAngleY(tmp2, angleY)
  mul(*res, tmp1, tmp2)
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleXYZ(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(-t1)
  Protected.f c2 = _math_::Cos(-t2)
  Protected.f c3 = _math_::Cos(-t3)
  Protected.f s1 = _math_::Sin(-t1)
  Protected.f s2 = _math_::Sin(-t2)
  Protected.f s3 = _math_::Sin(-t3)
  *res\v[0]\f[0] = c2 * c3 
  *res\v[0]\f[1] =(-c1) * s3 + s1 * s2 * c3
  *res\v[0]\f[2] = s1 * s3 + c1 * s2 * c3
  *res\v[0]\f[3] = 0
  *res\v[1]\f[0] = c2 * s3
  *res\v[1]\f[1] = c1 * c3 + s1 * s2 * s3
  *res\v[1]\f[2] =(-s1) * c3 + c1 * s2 * s3
  *res\v[1]\f[3] = 0
  *res\v[2]\f[0] =-s2
  *res\v[2]\f[1] = s1 * c2
  *res\v[2]\f[2] = c1 * c2
  *res\v[2]\f[3] = 0
  *res\v[3]\f[0] = 0
  *res\v[3]\f[1] = 0
  *res\v[3]\f[2] = 0
  *res\v[3]\f[3] = 1
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleYXZ(*res.mat4x4, yaw.f, pitch.f, roll.f)
  Protected.f tmp_ch = _math_::Cos(yaw)
  Protected.f tmp_sh = _math_::Sin(yaw)
  Protected.f tmp_cp = _math_::Cos(pitch)
  Protected.f tmp_sp = _math_::Sin(pitch)
  Protected.f tmp_cb = _math_::Cos(roll)
  Protected.f tmp_sb = _math_::Sin(roll)
  *res\v[0]\f[0] = tmp_ch * tmp_cb + tmp_sh * tmp_sp * tmp_sb
  *res\v[0]\f[1] = tmp_sb * tmp_cp
  *res\v[0]\f[2] = (-tmp_sh) * tmp_cb + tmp_ch * tmp_sp * tmp_sb
  *res\v[0]\f[3] = 0
  *res\v[1]\f[0] = (-tmp_ch) * tmp_sb + tmp_sh * tmp_sp * tmp_cb
  *res\v[1]\f[1] = tmp_cb * tmp_cp
  *res\v[1]\f[2] = tmp_sb * tmp_sh + tmp_ch * tmp_sp * tmp_cb
  *res\v[1]\f[3] = 0
  *res\v[2]\f[0] = tmp_sh * tmp_cp
  *res\v[2]\f[1] = -tmp_sp
  *res\v[2]\f[2] = tmp_ch * tmp_cp
  *res\v[2]\f[3] = 0
  *res\v[3]\f[0] = 0
  *res\v[3]\f[1] = 0
  *res\v[3]\f[2] = 0
  *res\v[3]\f[3] = 1
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleXZX(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1)
  Protected.f s1 = _math_::Sin(t1)
  Protected.f c2 = _math_::Cos(t2)
  Protected.f s2 = _math_::Sin(t2)
  Protected.f c3 = _math_::Cos(t3)
  Protected.f s3 = _math_::Sin(t3)
  *res\v[0]\f[0] = c2
  *res\v[0]\f[1] = c1 * s2
  *res\v[0]\f[2] = s1 * s2
  *res\v[0]\f[3] = 0
  *res\v[1]\f[0] =(-c3) * s2
  *res\v[1]\f[1] = c1 * c2 * c3 - s1 * s3
  *res\v[1]\f[2] = c1 * s3 + c2 * c3 * s1
  *res\v[1]\f[3] = 0
  *res\v[2]\f[0] = s2 * s3
  *res\v[2]\f[1] =(-c3) * s1 - c1 * c2 * s3
  *res\v[2]\f[2] = c1 * c3 - c2 * s1 * s3
  *res\v[2]\f[3] = 0
  *res\v[3]\f[0] = 0
  *res\v[3]\f[1] = 0
  *res\v[3]\f[2] = 0
  *res\v[3]\f[3] = 1
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleXYX(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1)
  Protected.f s1 = _math_::Sin(t1)
  Protected.f c2 = _math_::Cos(t2)
  Protected.f s2 = _math_::Sin(t2)
  Protected.f c3 = _math_::Cos(t3)
  Protected.f s3 = _math_::Sin(t3)
  *res\v[0]\f[0] = c2
  *res\v[0]\f[1] = s1 * s2
  *res\v[0]\f[2] =(-c1) * s2
  *res\v[0]\f[3] = 0
  *res\v[1]\f[0] = s2 * s3
  *res\v[1]\f[1] = c1 * c3 - c2 * s1 * s3
  *res\v[1]\f[2] = c3 * s1 + c1 * c2 * s3
  *res\v[1]\f[3] = 0
  *res\v[2]\f[0] = c3 * s2
  *res\v[2]\f[1] =(-c1) * s3 - c2 * c3 * s1
  *res\v[2]\f[2] = c1 * c2 * c3 - s1 * s3
  *res\v[2]\f[3] = 0
  *res\v[3]\f[0] = 0
  *res\v[3]\f[1] = 0
  *res\v[3]\f[2] = 0
  *res\v[3]\f[3] = 1
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleYXY(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1)
  Protected.f s1 = _math_::Sin(t1)
  Protected.f c2 = _math_::Cos(t2)
  Protected.f s2 = _math_::Sin(t2)
  Protected.f c3 = _math_::Cos(t3)
  Protected.f s3 = _math_::Sin(t3)
  *res\v[0]\f[0] = c1 * c3 - c2 * s1 * s3
  *res\v[0]\f[1] = s2* s3
  *res\v[0]\f[2] =(-c3) * s1 - c1 * c2 * s3
  *res\v[0]\f[3] = 0
  *res\v[1]\f[0] = s1 * s2
  *res\v[1]\f[1] = c2
  *res\v[1]\f[2] = c1 * s2
  *res\v[1]\f[3] = 0
  *res\v[2]\f[0] = c1 * s3 + c2 * c3 * s1
  *res\v[2]\f[1] =(-c3) * s2
  *res\v[2]\f[2] = c1 * c2 * c3 - s1 * s3
  *res\v[2]\f[3] = 0
  *res\v[3]\f[0] = 0
  *res\v[3]\f[1] = 0
  *res\v[3]\f[2] = 0
  *res\v[3]\f[3] = 1
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleYZY(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1)
  Protected.f s1 = _math_::Sin(t1)
  Protected.f c2 = _math_::Cos(t2)
  Protected.f s2 = _math_::Sin(t2)
  Protected.f c3 = _math_::Cos(t3)
  Protected.f s3 = _math_::Sin(t3)
  *res\v[0]\f[0] = c1 * c2 * c3 - s1 * s3 
  *res\v[0]\f[1] = c3 * s2 
  *res\v[0]\f[2] =(-c1) * s3 - c2 * c3 * s1 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] =(-c1) * s2 
  *res\v[1]\f[1] = c2 
  *res\v[1]\f[2] = s1 * s2 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = c3 * s1 + c1 * c2 * s3 
  *res\v[2]\f[1] = s2 * s3 
  *res\v[2]\f[2] = c1 * c3 - c2 * s1 * s3 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZYZ(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1) 
  Protected.f s1 = _math_::Sin(t1) 
  Protected.f c2 = _math_::Cos(t2) 
  Protected.f s2 = _math_::Sin(t2) 
  Protected.f c3 = _math_::Cos(t3) 
  Protected.f s3 = _math_::Sin(t3) 
  *res\v[0]\f[0] = c1 * c2 * c3 - s1 * s3 
  *res\v[0]\f[1] = c1 * s3 + c2 * c3 * s1 
  *res\v[0]\f[2] =(-c3) * s2 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] =(-c3) * s1 - c1 * c2 * s3 
  *res\v[1]\f[1] = c1 * c3 - c2 * s1 * s3 
  *res\v[1]\f[2] = s2 * s3 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = c1 * s2 
  *res\v[2]\f[1] = s1 * s2 
  *res\v[2]\f[2] = c2 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZXZ(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1) 
  Protected.f s1 = _math_::Sin(t1) 
  Protected.f c2 = _math_::Cos(t2) 
  Protected.f s2 = _math_::Sin(t2) 
  Protected.f c3 = _math_::Cos(t3) 
  Protected.f s3 = _math_::Sin(t3) 
  *res\v[0]\f[0] = c1 * c3 - c2 * s1 * s3 
  *res\v[0]\f[1] = c3 * s1 + c1 * c2 * s3 
  *res\v[0]\f[2] = s2 *s3 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] =(-c1) * s3 - c2 * c3 * s1 
  *res\v[1]\f[1] = c1 * c2 * c3 - s1 * s3 
  *res\v[1]\f[2] = c3 * s2 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = s1 * s2 
  *res\v[2]\f[1] =(-c1) * s2 
  *res\v[2]\f[2] = c2 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleXZY(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1) 
  Protected.f s1 = _math_::Sin(t1) 
  Protected.f c2 = _math_::Cos(t2) 
  Protected.f s2 = _math_::Sin(t2) 
  Protected.f c3 = _math_::Cos(t3) 
  Protected.f s3 = _math_::Sin(t3) 
  *res\v[0]\f[0] = c2 * c3 
  *res\v[0]\f[1] = s1 * s3 + c1 * c3 * s2 
  *res\v[0]\f[2] = c3 * s1 * s2 - c1 * s3 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] =-s2
  *res\v[1]\f[1] = c1 * c2 
  *res\v[1]\f[2] = c2 * s1 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = c2 * s3 
  *res\v[2]\f[1] = c1 * s2 * s3 - c3 * s1 
  *res\v[2]\f[2] = c1 * c3 + s1 * s2 *s3 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleYZX(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1) 
  Protected.f s1 = _math_::Sin(t1) 
  Protected.f c2 = _math_::Cos(t2) 
  Protected.f s2 = _math_::Sin(t2) 
  Protected.f c3 = _math_::Cos(t3) 
  Protected.f s3 = _math_::Sin(t3) 
  *res\v[0]\f[0] = c1 * c2 
  *res\v[0]\f[1] = s2 
  *res\v[0]\f[2] =(-c2) * s1 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] = s1 * s3 - c1 * c3 * s2 
  *res\v[1]\f[1] = c2 * c3 
  *res\v[1]\f[2] = c1 * s3 + c3 * s1 * s2 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = c3 * s1 + c1 * s2 * s3 
  *res\v[2]\f[1] =(-c2) * s3 
  *res\v[2]\f[2] = c1 * c3 - s1 * s2 * s3 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZYX(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1) 
  Protected.f s1 = _math_::Sin(t1) 
  Protected.f c2 = _math_::Cos(t2) 
  Protected.f s2 = _math_::Sin(t2) 
  Protected.f c3 = _math_::Cos(t3) 
  Protected.f s3 = _math_::Sin(t3) 
  *res\v[0]\f[0] = c1 * c2 
  *res\v[0]\f[1] = c2 * s1 
  *res\v[0]\f[2] =-s2 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] = c1 * s2 * s3 - c3 * s1 
  *res\v[1]\f[1] = c1 * c3 + s1 * s2 * s3 
  *res\v[1]\f[2] = c2 * s3 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = s1 * s3 + c1 * c3 * s2 
  *res\v[2]\f[1] = c3 * s1 * s2 - c1 * s3 
  *res\v[2]\f[2] = c2 * c3 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure eulerAngleZXY(*res.mat4x4, t1.f, t2.f, t3.f)
  Protected.f c1 = _math_::Cos(t1) 
  Protected.f s1 = _math_::Sin(t1) 
  Protected.f c2 = _math_::Cos(t2) 
  Protected.f s2 = _math_::Sin(t2) 
  Protected.f c3 = _math_::Cos(t3) 
  Protected.f s3 = _math_::Sin(t3) 
  *res\v[0]\f[0] = c1 * c3 - s1 * s2 * s3 
  *res\v[0]\f[1] = c3 * s1 + c1 * s2 * s3 
  *res\v[0]\f[2] =(-c2) * s3 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] =(-c2) * s1 
  *res\v[1]\f[1] = c1 * c2 
  *res\v[1]\f[2] = s2 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = c1 * s3 + c3 * s1 * s2 
  *res\v[2]\f[1] = s1 * s3 - c1 * c3 * s2 
  *res\v[2]\f[2] = c2 * c3 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure yawPitchRoll(*res.mat4x4, yaw.f, pitch.f, roll.f)
  Protected.f tmp_ch = _math_::Cos(yaw) 
  Protected.f tmp_sh = _math_::Sin(yaw) 
  Protected.f tmp_cp = _math_::Cos(pitch) 
  Protected.f tmp_sp = _math_::Sin(pitch) 
  Protected.f tmp_cb = _math_::Cos(roll) 
  Protected.f tmp_sb = _math_::Sin(roll) 
  *res\v[0]\f[0] = tmp_ch * tmp_cb + tmp_sh * tmp_sp * tmp_sb 
  *res\v[0]\f[1] = tmp_sb * tmp_cp 
  *res\v[0]\f[2] = (-tmp_sh) * tmp_cb + tmp_ch * tmp_sp * tmp_sb 
  *res\v[0]\f[3] = 0 
  *res\v[1]\f[0] = (-tmp_ch) * tmp_sb + tmp_sh * tmp_sp * tmp_cb 
  *res\v[1]\f[1] = tmp_cb * tmp_cp 
  *res\v[1]\f[2] = tmp_sb * tmp_sh + tmp_ch * tmp_sp * tmp_cb 
  *res\v[1]\f[3] = 0 
  *res\v[2]\f[0] = tmp_sh * tmp_cp 
  *res\v[2]\f[1] = -tmp_sp 
  *res\v[2]\f[2] = tmp_ch * tmp_cp 
  *res\v[2]\f[3] = 0 
  *res\v[3]\f[0] = 0 
  *res\v[3]\f[1] = 0 
  *res\v[3]\f[2] = 0 
  *res\v[3]\f[3] = 1 
  ProcedureReturn *res
EndProcedure
Procedure orientate2(*res.mat2x2, angle.f)
  Protected.f c = _math_::Cos(angle) 
  Protected.f s = _math_::Sin(angle) 
  *res\v[0]\f[0] = c 
  *res\v[0]\f[1] = s 
  *res\v[1]\f[0] = -s 
  *res\v[1]\f[1] = c 
  ProcedureReturn *res
EndProcedure
Procedure orientate3_float(*res.mat3x3, angle.f)
  Protected.f c = _math_::Cos(angle) 
  Protected.f s = _math_::Sin(angle) 
  *res\v[0]\f[0] = c 
  *res\v[0]\f[1] = s 
  *res\v[0]\f[2] = 0.0 
  *res\v[1]\f[0] = -s 
  *res\v[1]\f[1] = c 
  *res\v[1]\f[2] = 0.0 
  *res\v[2]\f[0] = 0.0 
  *res\v[2]\f[1] = 0.0 
  *res\v[2]\f[2] = 1.0 
  ProcedureReturn *res
EndProcedure
Procedure orientate3_vec3(*res.mat3x3, *angles.vec3)
  Protected.mat4x4 tmp
  yawPitchRoll(tmp, *angles\z, *angles\x, *angles\y)
  set(*res, tmp)
  ProcedureReturn *res
EndProcedure
Procedure orientate4(*res.mat4x4, *angles.vec3)
  yawPitchRoll(*res, *angles\z, *angles\x, *angles\y)
  ProcedureReturn *res
EndProcedure
Procedure extractEulerAngleXYZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[2]\f[1], *m\v[2]\f[2]) 
  Protected.f c2 = Sqr(*m\v[0]\f[0] * *m\v[0]\f[0] + *m\v[1]\f[0] * *m\v[1]\f[0]) 
  Protected.f t2 = _math_::ATan2(-*m\v[2]\f[0], C2) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(S1 * *m\v[0]\f[2] - C1 * *m\v[0]\f[1], C1 * *m\v[1]\f[1] - S1 * *m\v[1]\f[2]) 
  *t1\f = -T1 
  *t2\f = -T2 
  *t3\f = -T3 
EndProcedure
Procedure extractEulerAngleYXZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[2]\f[0], *m\v[2]\f[2]) 
  Protected.f c2 = Sqr(*m\v[0]\f[1] * *m\v[0]\f[1] + *m\v[1]\f[1] * *m\v[1]\f[1]) 
  Protected.f t2 = _math_::ATan2(-*m\v[2]\f[1], C2) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(S1 * *m\v[1]\f[2] - C1 * *m\v[1]\f[0], C1 * *m\v[0]\f[0] - S1 * *m\v[0]\f[2]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleXZX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[0]\f[2], *m\v[0]\f[1]) 
  Protected.f s2 = Sqr(*m\v[1]\f[0] * *m\v[1]\f[0] + *m\v[2]\f[0] * *m\v[2]\f[0]) 
  Protected.f t2 = _math_::ATan2(S2, *m\v[0]\f[0]) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(C1 * *m\v[1]\f[2] - S1 * *m\v[1]\f[1], C1 * *m\v[2]\f[2] - S1 * *m\v[2]\f[1]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleXYX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[0]\f[1], -*m\v[0]\f[2]) 
  Protected.f s2 = Sqr(*m\v[1]\f[0] * *m\v[1]\f[0] + *m\v[2]\f[0] * *m\v[2]\f[0]) 
  Protected.f t2 = _math_::ATan2(S2, *m\v[0]\f[0]) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(-C1 * *m\v[2]\f[1] - S1 * *m\v[2]\f[2], C1 * *m\v[1]\f[1] + S1 * *m\v[1]\f[2]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleYXY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[1]\f[0], *m\v[1]\f[2]) 
  Protected.f s2 = Sqr(*m\v[0]\f[1] * *m\v[0]\f[1] + *m\v[2]\f[1] * *m\v[2]\f[1]) 
  Protected.f t2 = _math_::ATan2(S2, *m\v[1]\f[1]) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(C1 * *m\v[2]\f[0] - S1 * *m\v[2]\f[2], C1 * *m\v[0]\f[0] - S1 * *m\v[0]\f[2]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleYZY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[1]\f[2], -*m\v[1]\f[0]) 
  Protected.f s2 = Sqr(*m\v[0]\f[1] * *m\v[0]\f[1] + *m\v[2]\f[1] * *m\v[2]\f[1]) 
  Protected.f t2 = _math_::ATan2(S2, *m\v[1]\f[1]) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(-S1 * *m\v[0]\f[0] - C1 * *m\v[0]\f[2], S1 * *m\v[2]\f[0] + C1 * *m\v[2]\f[2]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleZYZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[2]\f[1], *m\v[2]\f[0]) 
  Protected.f s2 = Sqr(*m\v[0]\f[2] * *m\v[0]\f[2] + *m\v[1]\f[2] * *m\v[1]\f[2]) 
  Protected.f t2 = _math_::ATan2(S2, *m\v[2]\f[2]) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(C1 * *m\v[0]\f[1] - S1 * *m\v[0]\f[0], C1 * *m\v[1]\f[1] - S1 * *m\v[1]\f[0]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleZXZ(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[2]\f[0], -*m\v[2]\f[1]) 
  Protected.f s2 = Sqr(*m\v[0]\f[2] * *m\v[0]\f[2] + *m\v[1]\f[2] * *m\v[1]\f[2]) 
  Protected.f t2 = _math_::ATan2(S2, *m\v[2]\f[2]) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(-C1 * *m\v[1]\f[0] - S1 * *m\v[1]\f[1], C1 * *m\v[0]\f[0] + S1 * *m\v[0]\f[1]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleXZY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[1]\f[2], *m\v[1]\f[1]) 
  Protected.f c2 = Sqr(*m\v[0]\f[0] * *m\v[0]\f[0] + *m\v[2]\f[0] * *m\v[2]\f[0]) 
  Protected.f t2 = _math_::ATan2(-*m\v[1]\f[0], C2) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(S1 * *m\v[0]\f[1] - C1 * *m\v[0]\f[2], C1 * *m\v[2]\f[2] - S1 * *m\v[2]\f[1]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleYZX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(-*m\v[0]\f[2], *m\v[0]\f[0]) 
  Protected.f c2 = Sqr(*m\v[1]\f[1] * *m\v[1]\f[1] + *m\v[2]\f[1] * *m\v[2]\f[1]) 
  Protected.f t2 = _math_::ATan2(*m\v[0]\f[1], C2) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(S1 * *m\v[1]\f[0] + C1 * *m\v[1]\f[2], S1 * *m\v[2]\f[0] + C1 * *m\v[2]\f[2]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleZYX(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(*m\v[0]\f[1], *m\v[0]\f[0]) 
  Protected.f c2 = Sqr(*m\v[1]\f[2] * *m\v[1]\f[2] + *m\v[2]\f[2] * *m\v[2]\f[2]) 
  Protected.f t2 = _math_::ATan2(-*m\v[0]\f[2], C2) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(S1 * *m\v[2]\f[0] - C1 * *m\v[2]\f[1], C1 * *m\v[1]\f[1] - S1 * *m\v[1]\f[0]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
Procedure extractEulerAngleZXY(*M.mat4x4, *t1.float, *t2.float, *t3.float)
  Protected.f t1 = _math_::ATan2(-*m\v[1]\f[0], *m\v[1]\f[1]) 
  Protected.f c2 = Sqr(*m\v[0]\f[2] * *m\v[0]\f[2] + *m\v[2]\f[2] * *m\v[2]\f[2]) 
  Protected.f t2 = _math_::ATan2(*m\v[1]\f[2], C2) 
  Protected.f s1 = _math_::Sin(T1) 
  Protected.f c1 = _math_::Cos(T1) 
  Protected.f t3 = _math_::ATan2(C1 * *m\v[2]\f[0] + S1 * *m\v[2]\f[1], C1 * *m\v[0]\f[0] + S1 * *m\v[0]\f[1]) 
  *t1\f = T1 
  *t2\f = T2 
  *t3\f = T3
EndProcedure
;}
EndModule
