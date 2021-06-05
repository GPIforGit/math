There are two ways to use math:


1) Simple copy the directory to your project and 
	XIncludeFile "math/math.pbi"
2) use the install-script, this will copy all the include-files to your pure-basic-compiler-directory. You can then use without any additional task use "math" with:
	XIncludeFile #PB_Compiler_Home + "Include/math/math.pbi"
	
	
Warning: Don't use "UseModule Math" - it will break things.


there are 4 vectors
	math::vec2
	math::vec3
	math::vec4
	
a quaternion
	math::quat
	
any many matrices
	math::mat2x2
	math::mat2x3
	math::mat2x4
	math::mat3x2
	math::mat3x3
	math::mat3x4
	math::mat4x2
	math::mat4x3
	math::mat4x4
	
For most procedure/macro the first parameter is a return-value.
Example-Code: Create two vectors and add them. Debug the result

	Define.math::vec3 v1,v2,vres
	math::vec3_set_float(v1, 1,2,3)
	math::vec3_set_float(v2, 2,4,5)

	math::vec3_add(vres, v1,v2)

	Debug math::string(vres)
	
there a "dispatcher" macros to simplfy things. These macros will detect the type of the parameter and choose the correct procedure.
same example:

	Define.math::vec3 v1,v2,vres
	math::set_float(v1, 1,2,3)
	math::set_float(v2, 2,4,5)

	math::add(vres, v1,v2)

	Debug math::string(vres)
	
example with a matrix:
	Define.math::vec3 v
	Define.math::vec3 vres
	Define.math::mat3x3 m

	math::set_float(m, 1) ; createas a identity matrix

	math::set_float(v,2) ; set all values of the vector to 2

	math::mul(vres, m, v) ; equals vres = m4*v

	Debug math::string(vres) + " = " + math::string(m) + " * " + math::string(v)
	
equals to
	Define.math::vec3 v
	Define.math::vec3 vres
	Define.math::mat3x3 m

	math::Mat3x3_set_Scalar(m, 1) ; createas a identity matrix

	math::vec3_set_Scalar(v,2) ; set all values of the vector to 2

	math::Mat3x3_mul_Vec3(vres, m, v) ; equals vres = m4*v

	Debug math::string(vres) + " = " + math::string(m) + " * " + math::string(v)

	
there are many more procedures in math:: - for example dot, length, cross and so on.
see test.pb for more example