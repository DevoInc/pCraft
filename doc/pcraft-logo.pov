#version 3.7;

global_settings {
  assumed_gamma 1.0
}

#declare lc_Black = texture { pigment { rgb <0.019608, 0.074510, 0.113725> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Blue = texture { pigment { rgb <0.000000, 0.333333, 0.749020> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Green = texture { pigment { rgb <0.145098, 0.478431, 0.243137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Turquoise = texture { pigment { rgb <0.000000, 0.513726, 0.560784> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Red = texture { pigment { rgb <0.788235, 0.101961, 0.035294> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Pink = texture { pigment { rgb <0.784314, 0.439216, 0.627451> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Brown = texture { pigment { rgb <0.345098, 0.223529, 0.152941> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Grey = texture { pigment { rgb <0.607843, 0.631373, 0.615686> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Grey = texture { pigment { rgb <0.427451, 0.431373, 0.360784> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Blue = texture { pigment { rgb <0.705882, 0.823529, 0.890196> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Bright_Green = texture { pigment { rgb <0.294118, 0.623529, 0.290196> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Turquoise = texture { pigment { rgb <0.333333, 0.647059, 0.686275> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Salmon = texture { pigment { rgb <0.949020, 0.439216, 0.368627> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pink = texture { pigment { rgb <0.988235, 0.592157, 0.674510> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Yellow = texture { pigment { rgb <0.949020, 0.803922, 0.215686> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_White = texture { pigment { rgb <1.000000, 1.000000, 1.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Green = texture { pigment { rgb <0.760784, 0.854902, 0.721569> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Yellow = texture { pigment { rgb <0.984314, 0.901961, 0.588235> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Tan = texture { pigment { rgb <0.894118, 0.803922, 0.619608> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Violet = texture { pigment { rgb <0.788235, 0.792157, 0.886275> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Purple = texture { pigment { rgb <0.505882, 0.000000, 0.482353> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Blue_Violet = texture { pigment { rgb <0.125490, 0.196078, 0.690196> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Orange = texture { pigment { rgb <0.996078, 0.541176, 0.094118> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Magenta = texture { pigment { rgb <0.572549, 0.223529, 0.470588> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Lime = texture { pigment { rgb <0.733333, 0.913725, 0.043137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Tan = texture { pigment { rgb <0.584314, 0.541176, 0.450980> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Bright_Pink = texture { pigment { rgb <0.894118, 0.678431, 0.784314> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Lavender = texture { pigment { rgb <0.674510, 0.470588, 0.729412> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Lavender = texture { pigment { rgb <0.882353, 0.835294, 0.929412> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Very_Light_Orange = texture { pigment { rgb <0.952941, 0.811765, 0.607843> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Bright_Reddish_Lilac = texture { pigment { rgb <0.803922, 0.384314, 0.596078> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Reddish_Brown = texture { pigment { rgb <0.345098, 0.164706, 0.070588> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Bluish_Grey = texture { pigment { rgb <0.627451, 0.647059, 0.662745> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Bluish_Grey = texture { pigment { rgb <0.423529, 0.431373, 0.407843> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Blue = texture { pigment { rgb <0.360784, 0.615686, 0.819608> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Green = texture { pigment { rgb <0.450980, 0.862745, 0.631373> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Pink = texture { pigment { rgb <0.996078, 0.800000, 0.811765> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Flesh = texture { pigment { rgb <0.964706, 0.843137, 0.701961> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Dark_Flesh = texture { pigment { rgb <0.800000, 0.439216, 0.164706> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Lilac = texture { pigment { rgb <0.247059, 0.211765, 0.568627> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Flesh = texture { pigment { rgb <0.486275, 0.313726, 0.227451> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Blue_Violet = texture { pigment { rgb <0.298039, 0.380392, 0.858824> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Flesh = texture { pigment { rgb <0.815686, 0.568627, 0.407843> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Salmon = texture { pigment { rgb <0.996078, 0.729412, 0.741176> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Violet = texture { pigment { rgb <0.262745, 0.329412, 0.639216> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Violet = texture { pigment { rgb <0.407843, 0.454902, 0.792157> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Lime = texture { pigment { rgb <0.780392, 0.823529, 0.235294> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Aqua = texture { pigment { rgb <0.701961, 0.843137, 0.819608> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Lime = texture { pigment { rgb <0.850980, 0.894118, 0.654902> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Orange = texture { pigment { rgb <0.976471, 0.729412, 0.380392> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Very_Light_Bluish_Grey = texture { pigment { rgb <0.901961, 0.890196, 0.878431> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Bright_Light_Orange = texture { pigment { rgb <0.972549, 0.733333, 0.239216> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Bright_Light_Blue = texture { pigment { rgb <0.525490, 0.756863, 0.882353> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rust = texture { pigment { rgb <0.701961, 0.062745, 0.015686> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Bright_Light_Yellow = texture { pigment { rgb <1.000000, 0.941176, 0.227451> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Sky_Blue = texture { pigment { rgb <0.337255, 0.745098, 0.839216> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Blue = texture { pigment { rgb <0.050980, 0.196078, 0.356863> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Green = texture { pigment { rgb <0.094118, 0.274510, 0.196078> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Brown = texture { pigment { rgb <0.207843, 0.129412, 0.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Maersk_Blue = texture { pigment { rgb <0.329412, 0.662745, 0.784314> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Red = texture { pigment { rgb <0.447059, 0.054902, 0.058824> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Azure = texture { pigment { rgb <0.078431, 0.596078, 0.843137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Azure = texture { pigment { rgb <0.243137, 0.760784, 0.866667> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Light_Aqua = texture { pigment { rgb <0.741176, 0.862745, 0.847059> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Yellowish_Green = texture { pigment { rgb <0.874510, 0.933333, 0.647059> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Olive_Green = texture { pigment { rgb <0.607843, 0.603922, 0.352941> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Sand_Red = texture { pigment { rgb <0.839216, 0.458824, 0.447059> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Dark_Pink = texture { pigment { rgb <0.968627, 0.521569, 0.694118> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Earth_Orange = texture { pigment { rgb <0.980392, 0.611765, 0.109804> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Sand_Purple = texture { pigment { rgb <0.517647, 0.368627, 0.517647> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Sand_Green = texture { pigment { rgb <0.627451, 0.737255, 0.674510> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Sand_Blue = texture { pigment { rgb <0.349020, 0.443137, 0.517647> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Fabuland_Brown = texture { pigment { rgb <0.713726, 0.482353, 0.313726> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Medium_Orange = texture { pigment { rgb <1.000000, 0.654902, 0.043137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Orange = texture { pigment { rgb <0.662745, 0.333333, 0.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Very_Light_Grey = texture { pigment { rgb <0.901961, 0.890196, 0.854902> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Reddish_Lilac = texture { pigment { rgb <0.556863, 0.333333, 0.592157> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Flamingo_Pink = texture { pigment { rgb <1.000000, 0.580392, 0.760784> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Lilac = texture { pigment { rgb <0.337255, 0.305882, 0.615686> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Dark_Nougat = texture { pigment { rgb <0.678431, 0.380392, 0.250980> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Trans_Clear = texture { pigment { rgb <0.988235, 0.988235, 0.988235> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Black = texture { pigment { rgb <0.388235, 0.372549, 0.321569> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Red = texture { pigment { rgb <0.788235, 0.101961, 0.035294> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Neon_Orange = texture { pigment { rgb <1.000000, 0.501961, 0.050980> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Orange = texture { pigment { rgb <0.941176, 0.560784, 0.109804> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Neon_Yellow = texture { pigment { rgb <0.854902, 0.690196, 0.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Yellow = texture { pigment { rgb <0.960784, 0.803922, 0.184314> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Neon_Green = texture { pigment { rgb <0.752941, 1.000000, 0.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Bright_Green = texture { pigment { rgb <0.337255, 0.901961, 0.274510> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Green = texture { pigment { rgb <0.137255, 0.470588, 0.254902> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Dark_Blue = texture { pigment { rgb <0.000000, 0.125490, 0.627451> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Medium_Blue = texture { pigment { rgb <0.333333, 0.603922, 0.717647> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Light_Blue = texture { pigment { rgb <0.682353, 0.913725, 0.937255> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Very_Light_Blue = texture { pigment { rgb <0.756863, 0.874510, 0.941176> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Bright_Reddish_Lilac = texture { pigment { rgb <0.588235, 0.439216, 0.623529> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Purple = texture { pigment { rgb <0.647059, 0.647059, 0.796078> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Dark_Pink = texture { pigment { rgb <0.874510, 0.400000, 0.584314> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Pink = texture { pigment { rgb <0.988235, 0.592157, 0.674510> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Light_Green = texture { pigment { rgb <0.490196, 0.760784, 0.568627> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Fire_Yellow = texture { pigment { rgb <0.984314, 0.909804, 0.564706> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Light_Blue_Violet = texture { pigment { rgb <0.419608, 0.670588, 0.894118> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Bright_Light_Orange = texture { pigment { rgb <0.988235, 0.717647, 0.427451> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Trans_Reddish_Lilac = texture { pigment { rgb <0.760784, 0.505882, 0.647059> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Chrome_Gold = texture { pigment { rgb <0.733333, 0.647059, 0.239216> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Chrome_Silver = texture { pigment { rgb <0.878431, 0.878431, 0.878431> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Chrome_Antique_Brass = texture { pigment { rgb <0.392157, 0.352941, 0.298039> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Chrome_Black = texture { pigment { rgb <0.105882, 0.164706, 0.203922> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Chrome_Blue = texture { pigment { rgb <0.423529, 0.588235, 0.749020> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Chrome_Green = texture { pigment { rgb <0.235294, 0.701961, 0.443137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Chrome_Pink = texture { pigment { rgb <0.666667, 0.301961, 0.556863> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pearl_White = texture { pigment { rgb <0.949020, 0.952941, 0.949020> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pearl_Very_Light_Grey = texture { pigment { rgb <0.733333, 0.741176, 0.737255> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pearl_Light_Grey = texture { pigment { rgb <0.611765, 0.639216, 0.658824> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Flat_Silver = texture { pigment { rgb <0.537255, 0.529412, 0.533333> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pearl_Dark_Grey = texture { pigment { rgb <0.341176, 0.345098, 0.341176> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metal_Blue = texture { pigment { rgb <0.337255, 0.466667, 0.729412> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pearl_Light_Gold = texture { pigment { rgb <0.862745, 0.745098, 0.380392> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Pearl_Gold = texture { pigment { rgb <0.800000, 0.611765, 0.168627> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Flat_Dark_Gold = texture { pigment { rgb <0.705882, 0.533333, 0.243137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Copper = texture { pigment { rgb <0.588235, 0.290196, 0.152941> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Reddish_Gold = texture { pigment { rgb <0.674510, 0.509804, 0.278431> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Silver = texture { pigment { rgb <0.647059, 0.662745, 0.705882> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Green = texture { pigment { rgb <0.537255, 0.607843, 0.372549> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Gold = texture { pigment { rgb <0.858824, 0.674510, 0.203922> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Black = texture { pigment { rgb <0.101961, 0.156863, 0.192157> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Dark_Grey = texture { pigment { rgb <0.427451, 0.431373, 0.360784> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Copper = texture { pigment { rgb <0.760784, 0.498039, 0.325490> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Bright_Red = texture { pigment { rgb <0.839216, 0.000000, 0.149020> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Metallic_Dark_Green = texture { pigment { rgb <0.000000, 0.556863, 0.235294> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Milky_White = texture { pigment { rgb <1.000000, 1.000000, 1.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glow_In_Dark_Opaque = texture { pigment { rgb <0.878431, 1.000000, 0.690196> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glow_In_Dark_Trans = texture { pigment { rgb <0.741176, 0.776471, 0.678431> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glow_In_Dark_White = texture { pigment { rgb <0.960784, 0.952941, 0.843137> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glitter_Trans_Dark_Pink = texture { pigment { rgb <0.874510, 0.400000, 0.584314> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glitter_Trans_Clear = texture { pigment { rgb <1.000000, 1.000000, 1.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glitter_Trans_Purple = texture { pigment { rgb <0.392157, 0.000000, 0.380392> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glitter_Trans_Light_Blue = texture { pigment { rgb <0.682353, 0.913725, 0.937255> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Glitter_Trans_Neon_Green = texture { pigment { rgb <0.752941, 1.000000, 0.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Speckle_Black_Silver = texture { pigment { rgb <0.000000, 0.000000, 0.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Speckle_Black_Gold = texture { pigment { rgb <0.000000, 0.000000, 0.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Speckle_Black_Copper = texture { pigment { rgb <0.000000, 0.000000, 0.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Speckle_Dark_Bluish_Grey_Silver = texture { pigment { rgb <0.388235, 0.372549, 0.380392> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Yellow = texture { pigment { rgb <0.960784, 0.803922, 0.184314> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Trans_Yellow = texture { pigment { rgb <0.792157, 0.690196, 0.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Rubber_Trans_Clear = texture { pigment { rgb <1.000000, 1.000000, 1.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Rubber_Black = texture { pigment { rgb <0.129412, 0.129412, 0.129412> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Blue = texture { pigment { rgb <0.000000, 0.200000, 0.698039> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Red = texture { pigment { rgb <0.768627, 0.000000, 0.149020> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Orange = texture { pigment { rgb <0.815686, 0.400000, 0.062745> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Light_Grey = texture { pigment { rgb <0.756863, 0.760784, 0.756863> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Dark_Blue = texture { pigment { rgb <0.000000, 0.113725, 0.407843> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Purple = texture { pigment { rgb <0.505882, 0.000000, 0.482353> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Lime = texture { pigment { rgb <0.843137, 0.941176, 0.000000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Light_Bluish_Grey = texture { pigment { rgb <0.639216, 0.635294, 0.643137> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_Flat_Silver = texture { pigment { rgb <0.537255, 0.529412, 0.533333> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Rubber_White = texture { pigment { rgb <0.980392, 0.980392, 0.980392> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Trans_Black_IR_Lens = texture { pigment { rgb <0.000000, 0.000000, 0.000000> filter 0.9 } finish { ambient 0.3 diffuse 0.2 reflection 0.25 phong 0.3 phong_size 60 } }
#declare lc_Magnet = texture { pigment { rgb <0.396078, 0.403922, 0.380392> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Electric_Contact_Alloy = texture { pigment { rgb <0.815686, 0.815686, 0.815686> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Electric_Contact_Copper = texture { pigment { rgb <0.682353, 0.478431, 0.349020> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Main_Colour = texture { pigment { rgb <1.000000, 1.000000, 0.501961> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Edge_Colour = texture { pigment { rgb <0.498039, 0.498039, 0.498039> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Color_B0A7D4 = texture { pigment { rgb <0.690196, 0.654902, 0.831373> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Color_333333 = texture { pigment { rgb <0.200000, 0.200000, 0.200000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Color_555555 = texture { pigment { rgb <0.333333, 0.333333, 0.333333> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Color_777777 = texture { pigment { rgb <0.466667, 0.466667, 0.466667> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Color_999999 = texture { pigment { rgb <0.600000, 0.600000, 0.600000> } finish { ambient 0.1 phong 0.2 phong_size 20 } }
#declare lc_Color_BBBBBB = texture { pigment { rgb <0.733333, 0.733333, 0.733333> } finish { ambient 0.1 phong 0.2 phong_size 20 } }

#declare lc_3003_dat = mesh {
  smooth_triangle { <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00>, <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00>, <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00>, <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00>, <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00>, <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00>, <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00>, <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00>, <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00>, <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00>, <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00>, <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00>, <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00>, <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00>, <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00>, <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00>, <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00>, <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00>, <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00>, <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00>, <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00>, <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00>, <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00>, <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00>, <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00>, <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00>, <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00>, <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00>, <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00>, <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00>, <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00>, <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00>, <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00>, <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00>, <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00>, <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00>, <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00>, <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00>, <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00>, <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00>, <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00>, <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00>, <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00>, <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00>, <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00>, <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00>, <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00>, <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00>, <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00>, <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00>, <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00>, <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00>, <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00>, <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00>, <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00>, <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00>, <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00>, <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00>, <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00>, <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00>, <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00>, <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00>, <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00>, <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00>, <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00>, <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00>, <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00>, <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00>, <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00>, <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00>, <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00>, <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00>, <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00>, <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00>, <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00>, <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00>, <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00>, <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00>, <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00>, <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00>, <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00>, <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00>, <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, -0.64, -0.16>, <-0.00, -0.00, -1.00>, <0.64, 0.64, -0.16>, <-0.00, -0.00, -1.00>, <-0.64, 0.64, -0.16>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, 0.64, -0.16>, <-0.00, -0.00, -1.00>, <-0.64, -0.64, -0.16>, <-0.00, -0.00, -1.00>, <0.64, -0.64, -0.16>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, -0.64, -0.96>, <1.00, -0.00, 0.00>, <-0.64, -0.64, -0.16>, <1.00, -0.00, 0.00>, <-0.64, 0.64, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 0.64, -0.16>, <1.00, -0.00, 0.00>, <-0.64, 0.64, -0.96>, <1.00, -0.00, 0.00>, <-0.64, -0.64, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 0.64, -0.96>, <-0.00, -1.00, 0.00>, <-0.64, 0.64, -0.16>, <-0.00, -1.00, 0.00>, <0.64, 0.64, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.64, 0.64, -0.16>, <-0.00, -1.00, 0.00>, <0.64, 0.64, -0.96>, <-0.00, -1.00, 0.00>, <-0.64, 0.64, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.64, 0.64, -0.96>, <-1.00, -0.00, 0.00>, <0.64, 0.64, -0.16>, <-1.00, -0.00, 0.00>, <0.64, -0.64, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -0.64, -0.16>, <-1.00, -0.00, 0.00>, <0.64, -0.64, -0.96>, <-1.00, -0.00, 0.00>, <0.64, 0.64, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -0.64, -0.96>, <-0.00, 1.00, 0.00>, <0.64, -0.64, -0.16>, <-0.00, 1.00, 0.00>, <-0.64, -0.64, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.64, -0.64, -0.16>, <-0.00, 1.00, 0.00>, <-0.64, -0.64, -0.96>, <-0.00, 1.00, 0.00>, <0.64, -0.64, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.64, 0.64, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, -0.64, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, 0.64, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, 0.64, -0.96>, <-0.00, -0.00, -1.00>, <0.80, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, 0.64, -0.96>, <-0.00, -0.00, -1.00>, <0.64, 0.64, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, -0.64, -0.96>, <-0.00, -0.00, -1.00>, <0.80, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.80, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.80, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.64, 0.64, -0.96>, <-0.00, -0.00, -1.00>, <0.64, -0.64, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, -0.64, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.80, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.80, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.64, -0.64, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, -0.64, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, 0.80, -0.00>, <-0.00, -0.00, 1.00>, <0.80, 0.80, -0.00>, <-0.00, -0.00, 1.00>, <0.80, -0.80, -0.00>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.80, -0.80, -0.00>, <-0.00, -0.00, 1.00>, <-0.80, -0.80, -0.00>, <-0.00, -0.00, 1.00>, <-0.80, 0.80, -0.00>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.80, 0.80, -0.00>, <-1.00, -0.00, 0.00>, <-0.80, -0.80, -0.00>, <-1.00, -0.00, 0.00>, <-0.80, -0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.80, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.80, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.80, 0.80, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.80, 0.80, -0.00>, <-0.00, 1.00, 0.00>, <-0.80, 0.80, -0.00>, <-0.00, 1.00, 0.00>, <-0.80, 0.80, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.80, 0.80, -0.96>, <-0.00, 1.00, 0.00>, <0.80, 0.80, -0.96>, <-0.00, 1.00, 0.00>, <0.80, 0.80, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.80, -0.80, -0.00>, <1.00, -0.00, 0.00>, <0.80, 0.80, -0.00>, <1.00, -0.00, 0.00>, <0.80, 0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.80, 0.80, -0.96>, <1.00, -0.00, 0.00>, <0.80, -0.80, -0.96>, <1.00, -0.00, 0.00>, <0.80, -0.80, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.80, -0.80, -0.00>, <-0.00, -1.00, 0.00>, <0.80, -0.80, -0.00>, <-0.00, -1.00, 0.00>, <0.80, -0.80, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.80, -0.80, -0.96>, <-0.00, -1.00, 0.00>, <-0.80, -0.80, -0.96>, <-0.00, -1.00, 0.00>, <-0.80, -0.80, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00>, <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00>, <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00>, <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00>, <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00>, <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00>, <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00>, <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00>, <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00>, <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00>, <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00>, <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00>, <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00>, <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00>, <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00>, <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00>, <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00>, <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00>, <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00>, <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00>, <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00>, <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00>, <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00>, <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00>, <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00>, <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00>, <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00>, <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00>, <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00>, <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00>, <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00>, <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00>, <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00>, <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00>, <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00>, <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00>, <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00>, <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00>, <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00>, <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00>, <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00>, <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00>, <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00>, <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00>, <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00>, <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00>, <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00>, <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00>, <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00>, <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00>, <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00>, <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00>, <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00>, <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00>, <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00>, <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00>, <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00>, <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00>, <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00>, <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00>, <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00>, <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00>, <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00>, <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00>, <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00>, <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00>, <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00>, <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00>, <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00>, <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00>, <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00>, <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00>, <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00>, <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00>, <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00>, <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00>, <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00>, <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00>, <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00>, <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00>, <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00>, <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00>, <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00>, <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00>, <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00>, <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00>, <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00>, <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00>, <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00>, <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00>, <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00>, <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00>, <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00>, <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00>, <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00>, <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00>, <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00>, <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00>, <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00>, <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00>, <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00>, <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00>, <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00>, <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00>, <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00> }
}

#declare lc_3003_dat_clear = lc_3003_dat

#declare lc_2456_dat = mesh {
  smooth_triangle { <-0.09, -1.82, -0.96>, <0.38, 0.92, 0.00>, <-0.00, -1.84, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -1.84, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.84, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, -1.82, -0.16>, <0.38, 0.92, 0.00>, <-0.09, -1.82, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, -1.77, -0.96>, <0.70, 0.70, 0.00>, <-0.09, -1.82, -0.96>, <0.38, 0.92, 0.00>, <-0.09, -1.82, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, -1.82, -0.16>, <0.38, 0.92, 0.00>, <-0.17, -1.77, -0.16>, <0.70, 0.70, 0.00>, <-0.17, -1.77, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, -1.69, -0.96>, <0.92, 0.38, 0.00>, <-0.17, -1.77, -0.96>, <0.70, 0.70, 0.00>, <-0.17, -1.77, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, -1.77, -0.16>, <0.70, 0.70, 0.00>, <-0.22, -1.69, -0.16>, <0.92, 0.38, 0.00>, <-0.22, -1.69, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, -1.60, -0.96>, <1.00, -0.00, 0.00>, <-0.22, -1.69, -0.96>, <0.92, 0.38, 0.00>, <-0.22, -1.69, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, -1.69, -0.16>, <0.92, 0.38, 0.00>, <-0.24, -1.60, -0.16>, <1.00, -0.00, 0.00>, <-0.24, -1.60, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, -1.51, -0.96>, <0.92, -0.38, 0.00>, <-0.24, -1.60, -0.96>, <1.00, -0.00, 0.00>, <-0.24, -1.60, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, -1.60, -0.16>, <1.00, -0.00, 0.00>, <-0.22, -1.51, -0.16>, <0.92, -0.38, 0.00>, <-0.22, -1.51, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, -1.43, -0.96>, <0.70, -0.70, 0.00>, <-0.22, -1.51, -0.96>, <0.92, -0.38, 0.00>, <-0.22, -1.51, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, -1.51, -0.16>, <0.92, -0.38, 0.00>, <-0.17, -1.43, -0.16>, <0.70, -0.70, 0.00>, <-0.17, -1.43, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, -1.38, -0.96>, <0.38, -0.92, 0.00>, <-0.17, -1.43, -0.96>, <0.70, -0.70, 0.00>, <-0.17, -1.43, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, -1.43, -0.16>, <0.70, -0.70, 0.00>, <-0.09, -1.38, -0.16>, <0.38, -0.92, 0.00>, <-0.09, -1.38, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, -1.36, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, -1.38, -0.96>, <0.38, -0.92, 0.00>, <-0.09, -1.38, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, -1.38, -0.16>, <0.38, -0.92, 0.00>, <-0.00, -1.36, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -1.36, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, -1.38, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, -1.36, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -1.36, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -1.36, -0.16>, <-0.00, -1.00, 0.00>, <0.09, -1.38, -0.16>, <-0.38, -0.92, 0.00>, <0.09, -1.38, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, -1.43, -0.96>, <-0.70, -0.70, 0.00>, <0.09, -1.38, -0.96>, <-0.38, -0.92, 0.00>, <0.09, -1.38, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, -1.38, -0.16>, <-0.38, -0.92, 0.00>, <0.17, -1.43, -0.16>, <-0.70, -0.70, 0.00>, <0.17, -1.43, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, -1.51, -0.96>, <-0.92, -0.38, 0.00>, <0.17, -1.43, -0.96>, <-0.70, -0.70, 0.00>, <0.17, -1.43, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, -1.43, -0.16>, <-0.70, -0.70, 0.00>, <0.22, -1.51, -0.16>, <-0.92, -0.38, 0.00>, <0.22, -1.51, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, -1.60, -0.96>, <-1.00, -0.00, 0.00>, <0.22, -1.51, -0.96>, <-0.92, -0.38, 0.00>, <0.22, -1.51, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, -1.51, -0.16>, <-0.92, -0.38, 0.00>, <0.24, -1.60, -0.16>, <-1.00, -0.00, 0.00>, <0.24, -1.60, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, -1.69, -0.96>, <-0.92, 0.38, 0.00>, <0.24, -1.60, -0.96>, <-1.00, -0.00, 0.00>, <0.24, -1.60, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, -1.60, -0.16>, <-1.00, -0.00, 0.00>, <0.22, -1.69, -0.16>, <-0.92, 0.38, 0.00>, <0.22, -1.69, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, -1.77, -0.96>, <-0.70, 0.70, 0.00>, <0.22, -1.69, -0.96>, <-0.92, 0.38, 0.00>, <0.22, -1.69, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, -1.69, -0.16>, <-0.92, 0.38, 0.00>, <0.17, -1.77, -0.16>, <-0.70, 0.70, 0.00>, <0.17, -1.77, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, -1.82, -0.96>, <-0.38, 0.92, 0.00>, <0.17, -1.77, -0.96>, <-0.70, 0.70, 0.00>, <0.17, -1.77, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, -1.77, -0.16>, <-0.70, 0.70, 0.00>, <0.09, -1.82, -0.16>, <-0.38, 0.92, 0.00>, <0.09, -1.82, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -1.84, -0.96>, <-0.00, 1.00, 0.00>, <0.09, -1.82, -0.96>, <-0.38, 0.92, 0.00>, <0.09, -1.82, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, -1.82, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, -1.84, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -1.84, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.92, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -1.92, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, -1.90, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, -1.90, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, -1.90, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, -1.92, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, -1.90, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, -1.90, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, -1.83, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -1.83, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, -1.83, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, -1.90, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, -1.83, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, -1.83, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, -1.72, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, -1.72, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, -1.72, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, -1.83, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, -1.72, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, -1.72, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, -1.60, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, -1.60, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, -1.60, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, -1.72, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, -1.60, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, -1.60, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, -1.48, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, -1.48, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, -1.48, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, -1.60, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, -1.48, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, -1.48, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, -1.37, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -1.37, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, -1.37, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, -1.48, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, -1.37, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, -1.37, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, -1.30, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, -1.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, -1.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, -1.37, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, -1.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, -1.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, -1.28, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.28, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -1.28, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, -1.30, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -1.28, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -1.28, -0.96>, <-0.00, 1.00, 0.00>, <0.12, -1.30, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, -1.30, -0.96>, <0.38, 0.92, 0.00>, <0.12, -1.30, -0.16>, <0.38, 0.92, 0.00>, <-0.00, -1.28, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, -1.30, -0.16>, <0.38, 0.92, 0.00>, <0.12, -1.30, -0.96>, <0.38, 0.92, 0.00>, <0.23, -1.37, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -1.37, -0.96>, <0.70, 0.70, 0.00>, <0.23, -1.37, -0.16>, <0.70, 0.70, 0.00>, <0.12, -1.30, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, -1.37, -0.16>, <0.70, 0.70, 0.00>, <0.23, -1.37, -0.96>, <0.70, 0.70, 0.00>, <0.30, -1.48, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, -1.48, -0.96>, <0.92, 0.38, 0.00>, <0.30, -1.48, -0.16>, <0.92, 0.38, 0.00>, <0.23, -1.37, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, -1.48, -0.16>, <0.92, 0.38, 0.00>, <0.30, -1.48, -0.96>, <0.92, 0.38, 0.00>, <0.32, -1.60, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, -1.60, -0.96>, <1.00, -0.00, 0.00>, <0.32, -1.60, -0.16>, <1.00, -0.00, 0.00>, <0.30, -1.48, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, -1.60, -0.16>, <1.00, -0.00, 0.00>, <0.32, -1.60, -0.96>, <1.00, -0.00, 0.00>, <0.30, -1.72, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, -1.72, -0.96>, <0.92, -0.38, 0.00>, <0.30, -1.72, -0.16>, <0.92, -0.38, 0.00>, <0.32, -1.60, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, -1.72, -0.16>, <0.92, -0.38, 0.00>, <0.30, -1.72, -0.96>, <0.92, -0.38, 0.00>, <0.23, -1.83, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -1.83, -0.96>, <0.70, -0.70, 0.00>, <0.23, -1.83, -0.16>, <0.70, -0.70, 0.00>, <0.30, -1.72, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, -1.83, -0.16>, <0.70, -0.70, 0.00>, <0.23, -1.83, -0.96>, <0.70, -0.70, 0.00>, <0.12, -1.90, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, -1.90, -0.96>, <0.38, -0.92, 0.00>, <0.12, -1.90, -0.16>, <0.38, -0.92, 0.00>, <0.23, -1.83, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, -1.90, -0.16>, <0.38, -0.92, 0.00>, <0.12, -1.90, -0.96>, <0.38, -0.92, 0.00>, <-0.00, -1.92, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -1.92, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -1.92, -0.16>, <-0.00, -1.00, 0.00>, <0.12, -1.90, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, -1.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -1.51, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -1.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -1.37, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -1.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -1.51, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -1.51, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -1.43, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.37, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -1.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.37, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -1.43, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -1.43, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.38, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.28, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.38, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -1.38, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.36, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.28, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -1.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.28, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.36, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.36, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.38, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -1.37, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.38, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -1.38, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -1.43, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.37, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -1.48, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.37, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -1.43, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -1.43, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -1.51, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -1.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -1.48, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -1.51, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -1.51, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -1.72, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -1.69, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -1.72, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -1.83, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -1.72, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -1.69, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -1.69, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -1.77, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.83, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -1.90, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.83, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -1.77, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -1.77, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.82, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.90, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.92, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.90, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.82, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -1.82, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.84, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -1.90, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.84, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.84, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.82, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.90, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -1.83, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.90, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.82, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -1.82, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -1.77, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.83, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, -1.72, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.83, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -1.77, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -1.77, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -1.69, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -1.72, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -1.72, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -1.69, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -1.69, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -1.02, -0.96>, <0.38, 0.92, 0.00>, <-0.00, -1.04, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -1.04, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.04, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, -1.02, -0.16>, <0.38, 0.92, 0.00>, <-0.09, -1.02, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, -0.97, -0.96>, <0.70, 0.70, 0.00>, <-0.09, -1.02, -0.96>, <0.38, 0.92, 0.00>, <-0.09, -1.02, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, -1.02, -0.16>, <0.38, 0.92, 0.00>, <-0.17, -0.97, -0.16>, <0.70, 0.70, 0.00>, <-0.17, -0.97, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, -0.89, -0.96>, <0.92, 0.38, 0.00>, <-0.17, -0.97, -0.96>, <0.70, 0.70, 0.00>, <-0.17, -0.97, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, -0.97, -0.16>, <0.70, 0.70, 0.00>, <-0.22, -0.89, -0.16>, <0.92, 0.38, 0.00>, <-0.22, -0.89, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, -0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.22, -0.89, -0.96>, <0.92, 0.38, 0.00>, <-0.22, -0.89, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, -0.89, -0.16>, <0.92, 0.38, 0.00>, <-0.24, -0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.24, -0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, -0.71, -0.96>, <0.92, -0.38, 0.00>, <-0.24, -0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.24, -0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, -0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.22, -0.71, -0.16>, <0.92, -0.38, 0.00>, <-0.22, -0.71, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, -0.63, -0.96>, <0.70, -0.70, 0.00>, <-0.22, -0.71, -0.96>, <0.92, -0.38, 0.00>, <-0.22, -0.71, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, -0.71, -0.16>, <0.92, -0.38, 0.00>, <-0.17, -0.63, -0.16>, <0.70, -0.70, 0.00>, <-0.17, -0.63, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, -0.58, -0.96>, <0.38, -0.92, 0.00>, <-0.17, -0.63, -0.96>, <0.70, -0.70, 0.00>, <-0.17, -0.63, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, -0.63, -0.16>, <0.70, -0.70, 0.00>, <-0.09, -0.58, -0.16>, <0.38, -0.92, 0.00>, <-0.09, -0.58, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, -0.56, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, -0.58, -0.96>, <0.38, -0.92, 0.00>, <-0.09, -0.58, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, -0.58, -0.16>, <0.38, -0.92, 0.00>, <-0.00, -0.56, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -0.56, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, -0.58, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, -0.56, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -0.56, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -0.56, -0.16>, <-0.00, -1.00, 0.00>, <0.09, -0.58, -0.16>, <-0.38, -0.92, 0.00>, <0.09, -0.58, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, -0.63, -0.96>, <-0.70, -0.70, 0.00>, <0.09, -0.58, -0.96>, <-0.38, -0.92, 0.00>, <0.09, -0.58, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, -0.58, -0.16>, <-0.38, -0.92, 0.00>, <0.17, -0.63, -0.16>, <-0.70, -0.70, 0.00>, <0.17, -0.63, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, -0.71, -0.96>, <-0.92, -0.38, 0.00>, <0.17, -0.63, -0.96>, <-0.70, -0.70, 0.00>, <0.17, -0.63, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, -0.63, -0.16>, <-0.70, -0.70, 0.00>, <0.22, -0.71, -0.16>, <-0.92, -0.38, 0.00>, <0.22, -0.71, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.22, -0.71, -0.96>, <-0.92, -0.38, 0.00>, <0.22, -0.71, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, -0.71, -0.16>, <-0.92, -0.38, 0.00>, <0.24, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.24, -0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, -0.89, -0.96>, <-0.92, 0.38, 0.00>, <0.24, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.24, -0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.22, -0.89, -0.16>, <-0.92, 0.38, 0.00>, <0.22, -0.89, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, -0.97, -0.96>, <-0.70, 0.70, 0.00>, <0.22, -0.89, -0.96>, <-0.92, 0.38, 0.00>, <0.22, -0.89, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, -0.89, -0.16>, <-0.92, 0.38, 0.00>, <0.17, -0.97, -0.16>, <-0.70, 0.70, 0.00>, <0.17, -0.97, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, -1.02, -0.96>, <-0.38, 0.92, 0.00>, <0.17, -0.97, -0.96>, <-0.70, 0.70, 0.00>, <0.17, -0.97, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, -0.97, -0.16>, <-0.70, 0.70, 0.00>, <0.09, -1.02, -0.16>, <-0.38, 0.92, 0.00>, <0.09, -1.02, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -1.04, -0.96>, <-0.00, 1.00, 0.00>, <0.09, -1.02, -0.96>, <-0.38, 0.92, 0.00>, <0.09, -1.02, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, -1.02, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, -1.04, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -1.04, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.12, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -1.12, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, -1.10, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, -1.10, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, -1.10, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, -1.12, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, -1.10, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, -1.10, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, -1.03, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -1.03, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, -1.03, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, -1.10, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, -1.03, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, -1.03, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, -0.92, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, -0.92, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, -0.92, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, -1.03, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, -0.92, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, -0.92, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, -0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, -0.92, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, -0.68, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, -0.68, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, -0.68, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, -0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, -0.68, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, -0.68, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, -0.57, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, -0.57, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, -0.68, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, -0.57, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, -0.50, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, -0.50, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, -0.50, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, -0.57, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, -0.50, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, -0.50, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, -0.48, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.48, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -0.48, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, -0.50, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -0.48, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -0.48, -0.96>, <-0.00, 1.00, 0.00>, <0.12, -0.50, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, -0.50, -0.96>, <0.38, 0.92, 0.00>, <0.12, -0.50, -0.16>, <0.38, 0.92, 0.00>, <-0.00, -0.48, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, -0.50, -0.16>, <0.38, 0.92, 0.00>, <0.12, -0.50, -0.96>, <0.38, 0.92, 0.00>, <0.23, -0.57, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.96>, <0.70, 0.70, 0.00>, <0.23, -0.57, -0.16>, <0.70, 0.70, 0.00>, <0.12, -0.50, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.16>, <0.70, 0.70, 0.00>, <0.23, -0.57, -0.96>, <0.70, 0.70, 0.00>, <0.30, -0.68, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, -0.68, -0.96>, <0.92, 0.38, 0.00>, <0.30, -0.68, -0.16>, <0.92, 0.38, 0.00>, <0.23, -0.57, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, -0.68, -0.16>, <0.92, 0.38, 0.00>, <0.30, -0.68, -0.96>, <0.92, 0.38, 0.00>, <0.32, -0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, -0.80, -0.96>, <1.00, -0.00, 0.00>, <0.32, -0.80, -0.16>, <1.00, -0.00, 0.00>, <0.30, -0.68, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, -0.80, -0.16>, <1.00, -0.00, 0.00>, <0.32, -0.80, -0.96>, <1.00, -0.00, 0.00>, <0.30, -0.92, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, -0.92, -0.96>, <0.92, -0.38, 0.00>, <0.30, -0.92, -0.16>, <0.92, -0.38, 0.00>, <0.32, -0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, -0.92, -0.16>, <0.92, -0.38, 0.00>, <0.30, -0.92, -0.96>, <0.92, -0.38, 0.00>, <0.23, -1.03, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -1.03, -0.96>, <0.70, -0.70, 0.00>, <0.23, -1.03, -0.16>, <0.70, -0.70, 0.00>, <0.30, -0.92, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, -1.03, -0.16>, <0.70, -0.70, 0.00>, <0.23, -1.03, -0.96>, <0.70, -0.70, 0.00>, <0.12, -1.10, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, -1.10, -0.96>, <0.38, -0.92, 0.00>, <0.12, -1.10, -0.16>, <0.38, -0.92, 0.00>, <0.23, -1.03, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, -1.10, -0.16>, <0.38, -0.92, 0.00>, <0.12, -1.10, -0.96>, <0.38, -0.92, 0.00>, <-0.00, -1.12, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -1.12, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -1.12, -0.16>, <-0.00, -1.00, 0.00>, <0.12, -1.10, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.56, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.56, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.56, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.12, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.04, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.04, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.04, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00>, <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00>, <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00>, <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00>, <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00>, <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00>, <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00>, <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00>, <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00>, <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00>, <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00>, <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00>, <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00>, <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00>, <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00>, <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00>, <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00>, <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00>, <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00>, <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00>, <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00>, <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00>, <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00>, <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00>, <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00>, <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00>, <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00>, <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00>, <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00>, <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00>, <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00>, <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00>, <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00>, <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00>, <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00>, <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00>, <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00>, <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00>, <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00>, <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00>, <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00>, <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00>, <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00>, <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00>, <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00>, <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00>, <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00>, <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00>, <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00>, <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00>, <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00>, <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00>, <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00>, <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00>, <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00>, <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00>, <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00>, <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00>, <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00>, <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00>, <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00>, <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00>, <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00>, <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00>, <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00>, <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00>, <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00>, <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00>, <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00>, <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00>, <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00>, <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00>, <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00>, <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00>, <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00>, <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00>, <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00>, <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00>, <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00>, <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00>, <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00>, <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00>, <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.58, -0.96>, <0.38, 0.92, 0.00>, <-0.00, 0.56, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 0.56, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.56, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, 0.58, -0.16>, <0.38, 0.92, 0.00>, <-0.09, 0.58, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, 0.63, -0.96>, <0.70, 0.70, 0.00>, <-0.09, 0.58, -0.96>, <0.38, 0.92, 0.00>, <-0.09, 0.58, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, 0.58, -0.16>, <0.38, 0.92, 0.00>, <-0.17, 0.63, -0.16>, <0.70, 0.70, 0.00>, <-0.17, 0.63, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, 0.71, -0.96>, <0.92, 0.38, 0.00>, <-0.17, 0.63, -0.96>, <0.70, 0.70, 0.00>, <-0.17, 0.63, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, 0.63, -0.16>, <0.70, 0.70, 0.00>, <-0.22, 0.71, -0.16>, <0.92, 0.38, 0.00>, <-0.22, 0.71, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, 0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.22, 0.71, -0.96>, <0.92, 0.38, 0.00>, <-0.22, 0.71, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, 0.71, -0.16>, <0.92, 0.38, 0.00>, <-0.24, 0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.24, 0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, 0.89, -0.96>, <0.92, -0.38, 0.00>, <-0.24, 0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.24, 0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, 0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.22, 0.89, -0.16>, <0.92, -0.38, 0.00>, <-0.22, 0.89, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, 0.97, -0.96>, <0.70, -0.70, 0.00>, <-0.22, 0.89, -0.96>, <0.92, -0.38, 0.00>, <-0.22, 0.89, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, 0.89, -0.16>, <0.92, -0.38, 0.00>, <-0.17, 0.97, -0.16>, <0.70, -0.70, 0.00>, <-0.17, 0.97, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, 1.02, -0.96>, <0.38, -0.92, 0.00>, <-0.17, 0.97, -0.96>, <0.70, -0.70, 0.00>, <-0.17, 0.97, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, 0.97, -0.16>, <0.70, -0.70, 0.00>, <-0.09, 1.02, -0.16>, <0.38, -0.92, 0.00>, <-0.09, 1.02, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, 1.04, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, 1.02, -0.96>, <0.38, -0.92, 0.00>, <-0.09, 1.02, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, 1.02, -0.16>, <0.38, -0.92, 0.00>, <-0.00, 1.04, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 1.04, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, 1.02, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, 1.04, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 1.04, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 1.04, -0.16>, <-0.00, -1.00, 0.00>, <0.09, 1.02, -0.16>, <-0.38, -0.92, 0.00>, <0.09, 1.02, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, 0.97, -0.96>, <-0.70, -0.70, 0.00>, <0.09, 1.02, -0.96>, <-0.38, -0.92, 0.00>, <0.09, 1.02, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, 1.02, -0.16>, <-0.38, -0.92, 0.00>, <0.17, 0.97, -0.16>, <-0.70, -0.70, 0.00>, <0.17, 0.97, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, 0.89, -0.96>, <-0.92, -0.38, 0.00>, <0.17, 0.97, -0.96>, <-0.70, -0.70, 0.00>, <0.17, 0.97, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, 0.97, -0.16>, <-0.70, -0.70, 0.00>, <0.22, 0.89, -0.16>, <-0.92, -0.38, 0.00>, <0.22, 0.89, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.22, 0.89, -0.96>, <-0.92, -0.38, 0.00>, <0.22, 0.89, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, 0.89, -0.16>, <-0.92, -0.38, 0.00>, <0.24, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.24, 0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, 0.71, -0.96>, <-0.92, 0.38, 0.00>, <0.24, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.24, 0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.22, 0.71, -0.16>, <-0.92, 0.38, 0.00>, <0.22, 0.71, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, 0.63, -0.96>, <-0.70, 0.70, 0.00>, <0.22, 0.71, -0.96>, <-0.92, 0.38, 0.00>, <0.22, 0.71, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, 0.71, -0.16>, <-0.92, 0.38, 0.00>, <0.17, 0.63, -0.16>, <-0.70, 0.70, 0.00>, <0.17, 0.63, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, 0.58, -0.96>, <-0.38, 0.92, 0.00>, <0.17, 0.63, -0.96>, <-0.70, 0.70, 0.00>, <0.17, 0.63, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, 0.63, -0.16>, <-0.70, 0.70, 0.00>, <0.09, 0.58, -0.16>, <-0.38, 0.92, 0.00>, <0.09, 0.58, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 0.56, -0.96>, <-0.00, 1.00, 0.00>, <0.09, 0.58, -0.96>, <-0.38, 0.92, 0.00>, <0.09, 0.58, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, 0.58, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, 0.56, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 0.56, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.48, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 0.48, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, 0.50, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, 0.50, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, 0.50, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, 0.48, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, 0.50, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, 0.50, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, 0.57, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, 0.57, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, 0.50, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, 0.57, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, 0.68, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, 0.68, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, 0.68, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, 0.57, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, 0.68, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, 0.68, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, 0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, 0.68, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, 0.92, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, 0.92, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, 0.92, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, 0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, 0.92, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, 0.92, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, 1.03, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 1.03, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, 1.03, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, 0.92, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, 1.03, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, 1.03, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, 1.10, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, 1.10, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, 1.10, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, 1.03, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, 1.10, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, 1.10, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, 1.12, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 1.12, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 1.12, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, 1.10, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 1.12, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 1.12, -0.96>, <-0.00, 1.00, 0.00>, <0.12, 1.10, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, 1.10, -0.96>, <0.38, 0.92, 0.00>, <0.12, 1.10, -0.16>, <0.38, 0.92, 0.00>, <-0.00, 1.12, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, 1.10, -0.16>, <0.38, 0.92, 0.00>, <0.12, 1.10, -0.96>, <0.38, 0.92, 0.00>, <0.23, 1.03, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 1.03, -0.96>, <0.70, 0.70, 0.00>, <0.23, 1.03, -0.16>, <0.70, 0.70, 0.00>, <0.12, 1.10, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, 1.03, -0.16>, <0.70, 0.70, 0.00>, <0.23, 1.03, -0.96>, <0.70, 0.70, 0.00>, <0.30, 0.92, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, 0.92, -0.96>, <0.92, 0.38, 0.00>, <0.30, 0.92, -0.16>, <0.92, 0.38, 0.00>, <0.23, 1.03, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, 0.92, -0.16>, <0.92, 0.38, 0.00>, <0.30, 0.92, -0.96>, <0.92, 0.38, 0.00>, <0.32, 0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, 0.80, -0.96>, <1.00, -0.00, 0.00>, <0.32, 0.80, -0.16>, <1.00, -0.00, 0.00>, <0.30, 0.92, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, 0.80, -0.16>, <1.00, -0.00, 0.00>, <0.32, 0.80, -0.96>, <1.00, -0.00, 0.00>, <0.30, 0.68, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, 0.68, -0.96>, <0.92, -0.38, 0.00>, <0.30, 0.68, -0.16>, <0.92, -0.38, 0.00>, <0.32, 0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, 0.68, -0.16>, <0.92, -0.38, 0.00>, <0.30, 0.68, -0.96>, <0.92, -0.38, 0.00>, <0.23, 0.57, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.96>, <0.70, -0.70, 0.00>, <0.23, 0.57, -0.16>, <0.70, -0.70, 0.00>, <0.30, 0.68, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.16>, <0.70, -0.70, 0.00>, <0.23, 0.57, -0.96>, <0.70, -0.70, 0.00>, <0.12, 0.50, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, 0.50, -0.96>, <0.38, -0.92, 0.00>, <0.12, 0.50, -0.16>, <0.38, -0.92, 0.00>, <0.23, 0.57, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, 0.50, -0.16>, <0.38, -0.92, 0.00>, <0.12, 0.50, -0.96>, <0.38, -0.92, 0.00>, <-0.00, 0.48, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 0.48, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 0.48, -0.16>, <-0.00, -1.00, 0.00>, <0.12, 0.50, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.04, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.04, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.04, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.48, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.56, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.56, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.56, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 1.38, -0.96>, <0.38, 0.92, 0.00>, <-0.00, 1.36, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 1.36, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 1.36, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, 1.38, -0.16>, <0.38, 0.92, 0.00>, <-0.09, 1.38, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, 1.43, -0.96>, <0.70, 0.70, 0.00>, <-0.09, 1.38, -0.96>, <0.38, 0.92, 0.00>, <-0.09, 1.38, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, 1.38, -0.16>, <0.38, 0.92, 0.00>, <-0.17, 1.43, -0.16>, <0.70, 0.70, 0.00>, <-0.17, 1.43, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, 1.51, -0.96>, <0.92, 0.38, 0.00>, <-0.17, 1.43, -0.96>, <0.70, 0.70, 0.00>, <-0.17, 1.43, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, 1.43, -0.16>, <0.70, 0.70, 0.00>, <-0.22, 1.51, -0.16>, <0.92, 0.38, 0.00>, <-0.22, 1.51, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, 1.60, -0.96>, <1.00, -0.00, 0.00>, <-0.22, 1.51, -0.96>, <0.92, 0.38, 0.00>, <-0.22, 1.51, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, 1.51, -0.16>, <0.92, 0.38, 0.00>, <-0.24, 1.60, -0.16>, <1.00, -0.00, 0.00>, <-0.24, 1.60, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, 1.69, -0.96>, <0.92, -0.38, 0.00>, <-0.24, 1.60, -0.96>, <1.00, -0.00, 0.00>, <-0.24, 1.60, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, 1.60, -0.16>, <1.00, -0.00, 0.00>, <-0.22, 1.69, -0.16>, <0.92, -0.38, 0.00>, <-0.22, 1.69, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, 1.77, -0.96>, <0.70, -0.70, 0.00>, <-0.22, 1.69, -0.96>, <0.92, -0.38, 0.00>, <-0.22, 1.69, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, 1.69, -0.16>, <0.92, -0.38, 0.00>, <-0.17, 1.77, -0.16>, <0.70, -0.70, 0.00>, <-0.17, 1.77, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, 1.82, -0.96>, <0.38, -0.92, 0.00>, <-0.17, 1.77, -0.96>, <0.70, -0.70, 0.00>, <-0.17, 1.77, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, 1.77, -0.16>, <0.70, -0.70, 0.00>, <-0.09, 1.82, -0.16>, <0.38, -0.92, 0.00>, <-0.09, 1.82, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, 1.84, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, 1.82, -0.96>, <0.38, -0.92, 0.00>, <-0.09, 1.82, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, 1.82, -0.16>, <0.38, -0.92, 0.00>, <-0.00, 1.84, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 1.84, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, 1.82, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, 1.84, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 1.84, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 1.84, -0.16>, <-0.00, -1.00, 0.00>, <0.09, 1.82, -0.16>, <-0.38, -0.92, 0.00>, <0.09, 1.82, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, 1.77, -0.96>, <-0.70, -0.70, 0.00>, <0.09, 1.82, -0.96>, <-0.38, -0.92, 0.00>, <0.09, 1.82, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, 1.82, -0.16>, <-0.38, -0.92, 0.00>, <0.17, 1.77, -0.16>, <-0.70, -0.70, 0.00>, <0.17, 1.77, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, 1.69, -0.96>, <-0.92, -0.38, 0.00>, <0.17, 1.77, -0.96>, <-0.70, -0.70, 0.00>, <0.17, 1.77, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, 1.77, -0.16>, <-0.70, -0.70, 0.00>, <0.22, 1.69, -0.16>, <-0.92, -0.38, 0.00>, <0.22, 1.69, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, 1.60, -0.96>, <-1.00, -0.00, 0.00>, <0.22, 1.69, -0.96>, <-0.92, -0.38, 0.00>, <0.22, 1.69, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, 1.69, -0.16>, <-0.92, -0.38, 0.00>, <0.24, 1.60, -0.16>, <-1.00, -0.00, 0.00>, <0.24, 1.60, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, 1.51, -0.96>, <-0.92, 0.38, 0.00>, <0.24, 1.60, -0.96>, <-1.00, -0.00, 0.00>, <0.24, 1.60, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, 1.60, -0.16>, <-1.00, -0.00, 0.00>, <0.22, 1.51, -0.16>, <-0.92, 0.38, 0.00>, <0.22, 1.51, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, 1.43, -0.96>, <-0.70, 0.70, 0.00>, <0.22, 1.51, -0.96>, <-0.92, 0.38, 0.00>, <0.22, 1.51, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, 1.51, -0.16>, <-0.92, 0.38, 0.00>, <0.17, 1.43, -0.16>, <-0.70, 0.70, 0.00>, <0.17, 1.43, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, 1.38, -0.96>, <-0.38, 0.92, 0.00>, <0.17, 1.43, -0.96>, <-0.70, 0.70, 0.00>, <0.17, 1.43, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, 1.43, -0.16>, <-0.70, 0.70, 0.00>, <0.09, 1.38, -0.16>, <-0.38, 0.92, 0.00>, <0.09, 1.38, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 1.36, -0.96>, <-0.00, 1.00, 0.00>, <0.09, 1.38, -0.96>, <-0.38, 0.92, 0.00>, <0.09, 1.38, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, 1.38, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, 1.36, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 1.36, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 1.28, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 1.28, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, 1.30, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, 1.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, 1.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, 1.28, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, 1.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, 1.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, 1.37, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 1.37, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, 1.37, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, 1.30, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, 1.37, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, 1.37, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, 1.48, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, 1.48, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, 1.48, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, 1.37, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, 1.48, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, 1.48, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, 1.60, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, 1.60, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, 1.60, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, 1.48, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, 1.60, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, 1.60, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, 1.72, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, 1.72, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, 1.72, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, 1.60, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, 1.72, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, 1.72, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, 1.83, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 1.83, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, 1.83, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, 1.72, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, 1.83, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, 1.83, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, 1.90, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, 1.90, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, 1.90, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, 1.83, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, 1.90, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, 1.90, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, 1.92, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 1.92, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 1.92, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, 1.90, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 1.92, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 1.92, -0.96>, <-0.00, 1.00, 0.00>, <0.12, 1.90, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, 1.90, -0.96>, <0.38, 0.92, 0.00>, <0.12, 1.90, -0.16>, <0.38, 0.92, 0.00>, <-0.00, 1.92, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, 1.90, -0.16>, <0.38, 0.92, 0.00>, <0.12, 1.90, -0.96>, <0.38, 0.92, 0.00>, <0.23, 1.83, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 1.83, -0.96>, <0.70, 0.70, 0.00>, <0.23, 1.83, -0.16>, <0.70, 0.70, 0.00>, <0.12, 1.90, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, 1.83, -0.16>, <0.70, 0.70, 0.00>, <0.23, 1.83, -0.96>, <0.70, 0.70, 0.00>, <0.30, 1.72, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, 1.72, -0.96>, <0.92, 0.38, 0.00>, <0.30, 1.72, -0.16>, <0.92, 0.38, 0.00>, <0.23, 1.83, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, 1.72, -0.16>, <0.92, 0.38, 0.00>, <0.30, 1.72, -0.96>, <0.92, 0.38, 0.00>, <0.32, 1.60, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, 1.60, -0.96>, <1.00, -0.00, 0.00>, <0.32, 1.60, -0.16>, <1.00, -0.00, 0.00>, <0.30, 1.72, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, 1.60, -0.16>, <1.00, -0.00, 0.00>, <0.32, 1.60, -0.96>, <1.00, -0.00, 0.00>, <0.30, 1.48, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, 1.48, -0.96>, <0.92, -0.38, 0.00>, <0.30, 1.48, -0.16>, <0.92, -0.38, 0.00>, <0.32, 1.60, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, 1.48, -0.16>, <0.92, -0.38, 0.00>, <0.30, 1.48, -0.96>, <0.92, -0.38, 0.00>, <0.23, 1.37, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 1.37, -0.96>, <0.70, -0.70, 0.00>, <0.23, 1.37, -0.16>, <0.70, -0.70, 0.00>, <0.30, 1.48, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, 1.37, -0.16>, <0.70, -0.70, 0.00>, <0.23, 1.37, -0.96>, <0.70, -0.70, 0.00>, <0.12, 1.30, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, 1.30, -0.96>, <0.38, -0.92, 0.00>, <0.12, 1.30, -0.16>, <0.38, -0.92, 0.00>, <0.23, 1.37, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, 1.30, -0.16>, <0.38, -0.92, 0.00>, <0.12, 1.30, -0.96>, <0.38, -0.92, 0.00>, <-0.00, 1.28, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 1.28, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 1.28, -0.16>, <-0.00, -1.00, 0.00>, <0.12, 1.30, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, 1.72, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, 1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 1.69, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 1.72, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 1.83, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 1.72, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 1.69, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 1.69, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 1.77, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.83, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 1.90, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.83, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 1.77, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 1.77, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.82, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.90, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.90, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.82, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 1.82, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.84, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 1.90, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.84, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.84, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.82, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.90, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 1.83, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.90, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.82, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 1.82, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 1.77, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.83, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 1.72, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.83, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 1.77, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 1.77, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 1.69, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 1.72, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 1.72, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 1.69, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 1.69, -0.96>, <-0.00, -0.00, -1.00>, <0.24, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.32, 1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 1.48, -0.96>, <-0.00, -0.00, -1.00>, <0.32, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.24, 1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 1.51, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 1.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 1.37, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 1.48, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 1.51, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 1.51, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 1.43, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.37, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 1.30, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.37, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 1.43, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 1.43, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.38, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.28, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.38, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 1.38, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.36, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.28, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 1.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.28, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.36, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.36, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.38, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 1.37, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.38, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 1.38, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 1.43, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.37, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, 1.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.37, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 1.43, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 1.43, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 1.51, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 1.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 1.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 1.51, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 1.51, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, 1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, -2.24, -0.16>, <-0.00, -0.00, -1.00>, <0.64, 2.24, -0.16>, <-0.00, -0.00, -1.00>, <-0.64, 2.24, -0.16>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, 2.24, -0.16>, <-0.00, -0.00, -1.00>, <-0.64, -2.24, -0.16>, <-0.00, -0.00, -1.00>, <0.64, -2.24, -0.16>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, -2.24, -0.96>, <1.00, -0.00, 0.00>, <-0.64, -2.24, -0.16>, <1.00, -0.00, 0.00>, <-0.64, 2.24, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 2.24, -0.16>, <1.00, -0.00, 0.00>, <-0.64, 2.24, -0.96>, <1.00, -0.00, 0.00>, <-0.64, -2.24, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 2.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.64, 2.24, -0.16>, <-0.00, -1.00, 0.00>, <0.64, 2.24, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.64, 2.24, -0.16>, <-0.00, -1.00, 0.00>, <0.64, 2.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.64, 2.24, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.64, 2.24, -0.96>, <-1.00, -0.00, 0.00>, <0.64, 2.24, -0.16>, <-1.00, -0.00, 0.00>, <0.64, -2.24, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -2.24, -0.16>, <-1.00, -0.00, 0.00>, <0.64, -2.24, -0.96>, <-1.00, -0.00, 0.00>, <0.64, 2.24, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -2.24, -0.96>, <-0.00, 1.00, 0.00>, <0.64, -2.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.64, -2.24, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.64, -2.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.64, -2.24, -0.96>, <-0.00, 1.00, 0.00>, <0.64, -2.24, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.64, 2.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, 2.40, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, -2.40, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, -2.40, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, -2.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, 2.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, 2.24, -0.96>, <-0.00, -0.00, -1.00>, <0.80, 2.40, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, 2.40, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, 2.40, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, 2.24, -0.96>, <-0.00, -0.00, -1.00>, <0.64, 2.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, -2.24, -0.96>, <-0.00, -0.00, -1.00>, <0.80, -2.40, -0.96>, <-0.00, -0.00, -1.00>, <0.80, 2.40, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.80, 2.40, -0.96>, <-0.00, -0.00, -1.00>, <0.64, 2.24, -0.96>, <-0.00, -0.00, -1.00>, <0.64, -2.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, -2.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, -2.40, -0.96>, <-0.00, -0.00, -1.00>, <0.80, -2.40, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.80, -2.40, -0.96>, <-0.00, -0.00, -1.00>, <0.64, -2.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, -2.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, 2.40, -0.00>, <-0.00, -0.00, 1.00>, <0.80, 2.40, -0.00>, <-0.00, -0.00, 1.00>, <0.80, -2.40, -0.00>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.80, -2.40, -0.00>, <-0.00, -0.00, 1.00>, <-0.80, -2.40, -0.00>, <-0.00, -0.00, 1.00>, <-0.80, 2.40, -0.00>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.80, 2.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.80, -2.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.80, -2.40, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.80, -2.40, -0.96>, <-1.00, -0.00, 0.00>, <-0.80, 2.40, -0.96>, <-1.00, -0.00, 0.00>, <-0.80, 2.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.80, 2.40, -0.00>, <-0.00, 1.00, 0.00>, <-0.80, 2.40, -0.00>, <-0.00, 1.00, 0.00>, <-0.80, 2.40, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.80, 2.40, -0.96>, <-0.00, 1.00, 0.00>, <0.80, 2.40, -0.96>, <-0.00, 1.00, 0.00>, <0.80, 2.40, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.80, -2.40, -0.00>, <1.00, -0.00, 0.00>, <0.80, 2.40, -0.00>, <1.00, -0.00, 0.00>, <0.80, 2.40, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.80, 2.40, -0.96>, <1.00, -0.00, 0.00>, <0.80, -2.40, -0.96>, <1.00, -0.00, 0.00>, <0.80, -2.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.80, -2.40, -0.00>, <-0.00, -1.00, 0.00>, <0.80, -2.40, -0.00>, <-0.00, -1.00, 0.00>, <0.80, -2.40, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.80, -2.40, -0.96>, <-0.00, -1.00, 0.00>, <-0.80, -2.40, -0.96>, <-0.00, -1.00, 0.00>, <-0.80, -2.40, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -2.24, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, -2.24, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, -2.22, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, -2.22, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, -2.22, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, -2.24, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, -2.22, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, -2.22, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, -2.17, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, -2.17, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, -2.17, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, -2.22, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, -2.17, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, -2.17, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, -2.09, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, -2.09, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, -2.09, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, -2.17, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, -2.09, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, -2.09, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, -2.00, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, -2.00, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, -2.00, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, -2.09, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, -2.00, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, -2.00, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, -1.91, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, -1.91, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, -1.91, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, -2.00, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, -1.91, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, -1.91, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, -1.83, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, -1.83, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, -1.83, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, -1.91, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, -1.83, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, -1.83, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, -1.78, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, -1.78, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, -1.78, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, -1.83, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, -1.78, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, -1.78, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, -1.76, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -1.76, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, -1.76, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, -1.78, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, -1.76, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, -1.76, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, -1.78, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, -1.78, -0.00>, <0.38, 0.92, 0.00>, <-0.31, -1.78, 0.16>, <0.38, 0.92, 0.00>, <-0.40, -1.76, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, -1.78, 0.16>, <0.38, 0.92, 0.00>, <-0.31, -1.78, -0.00>, <0.38, 0.92, 0.00>, <-0.23, -1.83, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -1.83, -0.00>, <0.70, 0.70, 0.00>, <-0.23, -1.83, 0.16>, <0.70, 0.70, 0.00>, <-0.31, -1.78, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, -1.83, 0.16>, <0.70, 0.70, 0.00>, <-0.23, -1.83, -0.00>, <0.70, 0.70, 0.00>, <-0.18, -1.91, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, -1.91, -0.00>, <0.92, 0.38, 0.00>, <-0.18, -1.91, 0.16>, <0.92, 0.38, 0.00>, <-0.23, -1.83, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, -1.91, 0.16>, <0.92, 0.38, 0.00>, <-0.18, -1.91, -0.00>, <0.92, 0.38, 0.00>, <-0.16, -2.00, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, -2.00, -0.00>, <1.00, -0.00, 0.00>, <-0.16, -2.00, 0.16>, <1.00, -0.00, 0.00>, <-0.18, -1.91, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, -2.00, 0.16>, <1.00, -0.00, 0.00>, <-0.16, -2.00, -0.00>, <1.00, -0.00, 0.00>, <-0.18, -2.09, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, -2.09, -0.00>, <0.92, -0.38, 0.00>, <-0.18, -2.09, 0.16>, <0.92, -0.38, 0.00>, <-0.16, -2.00, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, -2.09, 0.16>, <0.92, -0.38, 0.00>, <-0.18, -2.09, -0.00>, <0.92, -0.38, 0.00>, <-0.23, -2.17, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -2.17, -0.00>, <0.70, -0.70, 0.00>, <-0.23, -2.17, 0.16>, <0.70, -0.70, 0.00>, <-0.18, -2.09, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, -2.17, 0.16>, <0.70, -0.70, 0.00>, <-0.23, -2.17, -0.00>, <0.70, -0.70, 0.00>, <-0.31, -2.22, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, -2.22, -0.00>, <0.38, -0.92, 0.00>, <-0.31, -2.22, 0.16>, <0.38, -0.92, 0.00>, <-0.23, -2.17, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, -2.22, 0.16>, <0.38, -0.92, 0.00>, <-0.31, -2.22, -0.00>, <0.38, -0.92, 0.00>, <-0.40, -2.24, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -2.24, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, -2.24, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, -2.22, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -2.24, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -2.22, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -2.17, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -2.09, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.91, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.83, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -1.78, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -1.76, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -1.76, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -1.78, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.83, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.91, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -2.09, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -2.17, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -2.22, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -2.24, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, -1.42, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, -1.37, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, -1.42, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, -1.29, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, -1.37, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, -1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, -1.29, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, -1.11, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, -1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, -1.03, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, -1.11, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, -0.98, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, -1.03, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, -0.98, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, -0.98, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, -0.98, -0.00>, <0.38, 0.92, 0.00>, <-0.31, -0.98, 0.16>, <0.38, 0.92, 0.00>, <-0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, -0.98, 0.16>, <0.38, 0.92, 0.00>, <-0.31, -0.98, -0.00>, <0.38, 0.92, 0.00>, <-0.23, -1.03, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -1.03, -0.00>, <0.70, 0.70, 0.00>, <-0.23, -1.03, 0.16>, <0.70, 0.70, 0.00>, <-0.31, -0.98, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, -1.03, 0.16>, <0.70, 0.70, 0.00>, <-0.23, -1.03, -0.00>, <0.70, 0.70, 0.00>, <-0.18, -1.11, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, -1.11, -0.00>, <0.92, 0.38, 0.00>, <-0.18, -1.11, 0.16>, <0.92, 0.38, 0.00>, <-0.23, -1.03, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, -1.11, 0.16>, <0.92, 0.38, 0.00>, <-0.18, -1.11, -0.00>, <0.92, 0.38, 0.00>, <-0.16, -1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, -1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.16, -1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.18, -1.11, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, -1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.16, -1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.18, -1.29, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, -1.29, -0.00>, <0.92, -0.38, 0.00>, <-0.18, -1.29, 0.16>, <0.92, -0.38, 0.00>, <-0.16, -1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, -1.29, 0.16>, <0.92, -0.38, 0.00>, <-0.18, -1.29, -0.00>, <0.92, -0.38, 0.00>, <-0.23, -1.37, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -1.37, -0.00>, <0.70, -0.70, 0.00>, <-0.23, -1.37, 0.16>, <0.70, -0.70, 0.00>, <-0.18, -1.29, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, -1.37, 0.16>, <0.70, -0.70, 0.00>, <-0.23, -1.37, -0.00>, <0.70, -0.70, 0.00>, <-0.31, -1.42, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, -1.42, -0.00>, <0.38, -0.92, 0.00>, <-0.31, -1.42, 0.16>, <0.38, -0.92, 0.00>, <-0.23, -1.37, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, -1.42, 0.16>, <0.38, -0.92, 0.00>, <-0.31, -1.42, -0.00>, <0.38, -0.92, 0.00>, <-0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, -1.42, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00>, <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00>, <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00>, <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00>, <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00>, <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00>, <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00>, <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00>, <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00>, <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00>, <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00>, <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00>, <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00>, <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00>, <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00>, <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00>, <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00>, <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00>, <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00>, <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00>, <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00>, <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00>, <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00>, <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00>, <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00>, <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00>, <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00>, <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00>, <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00>, <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00>, <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00>, <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00>, <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00>, <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00>, <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00>, <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00>, <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00>, <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00>, <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00>, <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00>, <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00>, <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00>, <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00>, <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00>, <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00>, <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00>, <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00>, <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00>, <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, 0.98, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, 1.03, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, 0.98, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, 1.11, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, 1.03, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, 1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, 1.11, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, 1.29, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, 1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, 1.37, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, 1.29, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, 1.42, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, 1.37, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, 1.42, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, 1.42, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, 1.42, -0.00>, <0.38, 0.92, 0.00>, <-0.31, 1.42, 0.16>, <0.38, 0.92, 0.00>, <-0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, 1.42, 0.16>, <0.38, 0.92, 0.00>, <-0.31, 1.42, -0.00>, <0.38, 0.92, 0.00>, <-0.23, 1.37, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 1.37, -0.00>, <0.70, 0.70, 0.00>, <-0.23, 1.37, 0.16>, <0.70, 0.70, 0.00>, <-0.31, 1.42, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, 1.37, 0.16>, <0.70, 0.70, 0.00>, <-0.23, 1.37, -0.00>, <0.70, 0.70, 0.00>, <-0.18, 1.29, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, 1.29, -0.00>, <0.92, 0.38, 0.00>, <-0.18, 1.29, 0.16>, <0.92, 0.38, 0.00>, <-0.23, 1.37, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, 1.29, 0.16>, <0.92, 0.38, 0.00>, <-0.18, 1.29, -0.00>, <0.92, 0.38, 0.00>, <-0.16, 1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, 1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.16, 1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.18, 1.29, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, 1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.16, 1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.18, 1.11, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, 1.11, -0.00>, <0.92, -0.38, 0.00>, <-0.18, 1.11, 0.16>, <0.92, -0.38, 0.00>, <-0.16, 1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, 1.11, 0.16>, <0.92, -0.38, 0.00>, <-0.18, 1.11, -0.00>, <0.92, -0.38, 0.00>, <-0.23, 1.03, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 1.03, -0.00>, <0.70, -0.70, 0.00>, <-0.23, 1.03, 0.16>, <0.70, -0.70, 0.00>, <-0.18, 1.11, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, 1.03, 0.16>, <0.70, -0.70, 0.00>, <-0.23, 1.03, -0.00>, <0.70, -0.70, 0.00>, <-0.31, 0.98, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, 0.98, -0.00>, <0.38, -0.92, 0.00>, <-0.31, 0.98, 0.16>, <0.38, -0.92, 0.00>, <-0.23, 1.03, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, 0.98, 0.16>, <0.38, -0.92, 0.00>, <-0.31, 0.98, -0.00>, <0.38, -0.92, 0.00>, <-0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, 0.98, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.76, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, 1.76, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, 1.78, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, 1.78, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, 1.78, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, 1.76, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, 1.78, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, 1.78, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, 1.83, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, 1.83, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, 1.83, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, 1.78, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, 1.83, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, 1.83, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, 1.91, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, 1.91, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, 1.91, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, 1.83, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, 1.91, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, 1.91, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, 2.00, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 2.00, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, 2.00, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, 1.91, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, 2.00, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, 2.00, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, 2.09, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, 2.09, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, 2.09, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, 2.00, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, 2.09, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, 2.09, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, 2.17, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, 2.17, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, 2.17, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, 2.09, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, 2.17, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, 2.17, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, 2.22, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, 2.22, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, 2.22, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, 2.17, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, 2.22, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, 2.22, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, 2.24, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, 2.24, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, 2.24, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, 2.22, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, 2.24, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, 2.24, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, 2.22, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, 2.22, -0.00>, <0.38, 0.92, 0.00>, <-0.31, 2.22, 0.16>, <0.38, 0.92, 0.00>, <-0.40, 2.24, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, 2.22, 0.16>, <0.38, 0.92, 0.00>, <-0.31, 2.22, -0.00>, <0.38, 0.92, 0.00>, <-0.23, 2.17, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 2.17, -0.00>, <0.70, 0.70, 0.00>, <-0.23, 2.17, 0.16>, <0.70, 0.70, 0.00>, <-0.31, 2.22, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, 2.17, 0.16>, <0.70, 0.70, 0.00>, <-0.23, 2.17, -0.00>, <0.70, 0.70, 0.00>, <-0.18, 2.09, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, 2.09, -0.00>, <0.92, 0.38, 0.00>, <-0.18, 2.09, 0.16>, <0.92, 0.38, 0.00>, <-0.23, 2.17, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, 2.09, 0.16>, <0.92, 0.38, 0.00>, <-0.18, 2.09, -0.00>, <0.92, 0.38, 0.00>, <-0.16, 2.00, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, 2.00, -0.00>, <1.00, -0.00, 0.00>, <-0.16, 2.00, 0.16>, <1.00, -0.00, 0.00>, <-0.18, 2.09, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, 2.00, 0.16>, <1.00, -0.00, 0.00>, <-0.16, 2.00, -0.00>, <1.00, -0.00, 0.00>, <-0.18, 1.91, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, 1.91, -0.00>, <0.92, -0.38, 0.00>, <-0.18, 1.91, 0.16>, <0.92, -0.38, 0.00>, <-0.16, 2.00, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, 1.91, 0.16>, <0.92, -0.38, 0.00>, <-0.18, 1.91, -0.00>, <0.92, -0.38, 0.00>, <-0.23, 1.83, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 1.83, -0.00>, <0.70, -0.70, 0.00>, <-0.23, 1.83, 0.16>, <0.70, -0.70, 0.00>, <-0.18, 1.91, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, 1.83, 0.16>, <0.70, -0.70, 0.00>, <-0.23, 1.83, -0.00>, <0.70, -0.70, 0.00>, <-0.31, 1.78, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, 1.78, -0.00>, <0.38, -0.92, 0.00>, <-0.31, 1.78, 0.16>, <0.38, -0.92, 0.00>, <-0.23, 1.83, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, 1.78, 0.16>, <0.38, -0.92, 0.00>, <-0.31, 1.78, -0.00>, <0.38, -0.92, 0.00>, <-0.40, 1.76, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, 1.76, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, 1.76, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, 1.78, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 1.76, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 1.78, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.83, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.91, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 2.09, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 2.17, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 2.22, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 2.24, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 2.24, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 2.22, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 2.17, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 2.09, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.91, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.83, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 1.78, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 1.76, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.24, 0.16>, <-0.00, -1.00, 0.00>, <0.40, -2.24, -0.00>, <-0.00, -1.00, 0.00>, <0.31, -2.22, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, -2.22, -0.00>, <-0.38, -0.92, 0.00>, <0.31, -2.22, 0.16>, <-0.38, -0.92, 0.00>, <0.40, -2.24, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, -2.22, 0.16>, <-0.38, -0.92, 0.00>, <0.31, -2.22, -0.00>, <-0.38, -0.92, 0.00>, <0.23, -2.17, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -2.17, -0.00>, <-0.70, -0.70, 0.00>, <0.23, -2.17, 0.16>, <-0.70, -0.70, 0.00>, <0.31, -2.22, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, -2.17, 0.16>, <-0.70, -0.70, 0.00>, <0.23, -2.17, -0.00>, <-0.70, -0.70, 0.00>, <0.18, -2.09, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, -2.09, -0.00>, <-0.92, -0.38, 0.00>, <0.18, -2.09, 0.16>, <-0.92, -0.38, 0.00>, <0.23, -2.17, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, -2.09, 0.16>, <-0.92, -0.38, 0.00>, <0.18, -2.09, -0.00>, <-0.92, -0.38, 0.00>, <0.16, -2.00, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, -2.00, -0.00>, <-1.00, -0.00, 0.00>, <0.16, -2.00, 0.16>, <-1.00, -0.00, 0.00>, <0.18, -2.09, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, -2.00, 0.16>, <-1.00, -0.00, 0.00>, <0.16, -2.00, -0.00>, <-1.00, -0.00, 0.00>, <0.18, -1.91, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, -1.91, -0.00>, <-0.92, 0.38, 0.00>, <0.18, -1.91, 0.16>, <-0.92, 0.38, 0.00>, <0.16, -2.00, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, -1.91, 0.16>, <-0.92, 0.38, 0.00>, <0.18, -1.91, -0.00>, <-0.92, 0.38, 0.00>, <0.23, -1.83, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -1.83, -0.00>, <-0.70, 0.70, 0.00>, <0.23, -1.83, 0.16>, <-0.70, 0.70, 0.00>, <0.18, -1.91, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, -1.83, 0.16>, <-0.70, 0.70, 0.00>, <0.23, -1.83, -0.00>, <-0.70, 0.70, 0.00>, <0.31, -1.78, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, -1.78, -0.00>, <-0.38, 0.92, 0.00>, <0.31, -1.78, 0.16>, <-0.38, 0.92, 0.00>, <0.23, -1.83, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, -1.78, 0.16>, <-0.38, 0.92, 0.00>, <0.31, -1.78, -0.00>, <-0.38, 0.92, 0.00>, <0.40, -1.76, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, -1.76, -0.00>, <-0.00, 1.00, 0.00>, <0.40, -1.76, 0.16>, <-0.00, 1.00, 0.00>, <0.31, -1.78, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, -1.76, 0.16>, <-0.00, 1.00, 0.00>, <0.40, -1.76, -0.00>, <-0.00, 1.00, 0.00>, <0.49, -1.78, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, -1.78, -0.00>, <0.38, 0.92, 0.00>, <0.49, -1.78, 0.16>, <0.38, 0.92, 0.00>, <0.40, -1.76, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, -1.78, 0.16>, <0.38, 0.92, 0.00>, <0.49, -1.78, -0.00>, <0.38, 0.92, 0.00>, <0.57, -1.83, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, -1.83, -0.00>, <0.70, 0.70, 0.00>, <0.57, -1.83, 0.16>, <0.70, 0.70, 0.00>, <0.49, -1.78, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, -1.83, 0.16>, <0.70, 0.70, 0.00>, <0.57, -1.83, -0.00>, <0.70, 0.70, 0.00>, <0.62, -1.91, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, -1.91, -0.00>, <0.92, 0.38, 0.00>, <0.62, -1.91, 0.16>, <0.92, 0.38, 0.00>, <0.57, -1.83, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, -1.91, 0.16>, <0.92, 0.38, 0.00>, <0.62, -1.91, -0.00>, <0.92, 0.38, 0.00>, <0.64, -2.00, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -2.00, -0.00>, <1.00, -0.00, 0.00>, <0.64, -2.00, 0.16>, <1.00, -0.00, 0.00>, <0.62, -1.91, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, -2.00, 0.16>, <1.00, -0.00, 0.00>, <0.64, -2.00, -0.00>, <1.00, -0.00, 0.00>, <0.62, -2.09, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, -2.09, -0.00>, <0.92, -0.38, 0.00>, <0.62, -2.09, 0.16>, <0.92, -0.38, 0.00>, <0.64, -2.00, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, -2.09, 0.16>, <0.92, -0.38, 0.00>, <0.62, -2.09, -0.00>, <0.92, -0.38, 0.00>, <0.57, -2.17, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, -2.17, -0.00>, <0.70, -0.70, 0.00>, <0.57, -2.17, 0.16>, <0.70, -0.70, 0.00>, <0.62, -2.09, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, -2.17, 0.16>, <0.70, -0.70, 0.00>, <0.57, -2.17, -0.00>, <0.70, -0.70, 0.00>, <0.49, -2.22, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, -2.22, -0.00>, <0.38, -0.92, 0.00>, <0.49, -2.22, 0.16>, <0.38, -0.92, 0.00>, <0.57, -2.17, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, -2.22, 0.16>, <0.38, -0.92, 0.00>, <0.49, -2.22, -0.00>, <0.38, -0.92, 0.00>, <0.40, -2.24, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, -2.24, -0.00>, <-0.00, -1.00, 0.00>, <0.40, -2.24, 0.16>, <-0.00, -1.00, 0.00>, <0.49, -2.22, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -2.24, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -2.22, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -2.17, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -2.09, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.91, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.83, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -1.78, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -1.76, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -1.76, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -1.78, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.83, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.91, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -2.09, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -2.17, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -2.22, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -2.24, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <0.31, -1.42, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <0.31, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <0.31, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <0.23, -1.37, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <0.23, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <0.31, -1.42, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <0.23, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <0.18, -1.29, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <0.18, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <0.23, -1.37, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <0.18, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <0.16, -1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.16, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.18, -1.29, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.16, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.18, -1.11, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <0.18, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <0.16, -1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <0.18, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <0.23, -1.03, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <0.23, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <0.18, -1.11, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <0.23, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <0.31, -0.98, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <0.31, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <0.23, -1.03, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <0.31, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <0.31, -0.98, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <0.49, -0.98, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, -0.98, -0.00>, <0.38, 0.92, 0.00>, <0.49, -0.98, 0.16>, <0.38, 0.92, 0.00>, <0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, -0.98, 0.16>, <0.38, 0.92, 0.00>, <0.49, -0.98, -0.00>, <0.38, 0.92, 0.00>, <0.57, -1.03, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, -1.03, -0.00>, <0.70, 0.70, 0.00>, <0.57, -1.03, 0.16>, <0.70, 0.70, 0.00>, <0.49, -0.98, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, -1.03, 0.16>, <0.70, 0.70, 0.00>, <0.57, -1.03, -0.00>, <0.70, 0.70, 0.00>, <0.62, -1.11, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, -1.11, -0.00>, <0.92, 0.38, 0.00>, <0.62, -1.11, 0.16>, <0.92, 0.38, 0.00>, <0.57, -1.03, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, -1.11, 0.16>, <0.92, 0.38, 0.00>, <0.62, -1.11, -0.00>, <0.92, 0.38, 0.00>, <0.64, -1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -1.20, -0.00>, <1.00, -0.00, 0.00>, <0.64, -1.20, 0.16>, <1.00, -0.00, 0.00>, <0.62, -1.11, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, -1.20, 0.16>, <1.00, -0.00, 0.00>, <0.64, -1.20, -0.00>, <1.00, -0.00, 0.00>, <0.62, -1.29, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, -1.29, -0.00>, <0.92, -0.38, 0.00>, <0.62, -1.29, 0.16>, <0.92, -0.38, 0.00>, <0.64, -1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, -1.29, 0.16>, <0.92, -0.38, 0.00>, <0.62, -1.29, -0.00>, <0.92, -0.38, 0.00>, <0.57, -1.37, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, -1.37, -0.00>, <0.70, -0.70, 0.00>, <0.57, -1.37, 0.16>, <0.70, -0.70, 0.00>, <0.62, -1.29, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, -1.37, 0.16>, <0.70, -0.70, 0.00>, <0.57, -1.37, -0.00>, <0.70, -0.70, 0.00>, <0.49, -1.42, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, -1.42, -0.00>, <0.38, -0.92, 0.00>, <0.49, -1.42, 0.16>, <0.38, -0.92, 0.00>, <0.57, -1.37, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, -1.42, 0.16>, <0.38, -0.92, 0.00>, <0.49, -1.42, -0.00>, <0.38, -0.92, 0.00>, <0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <0.49, -1.42, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00>, <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00>, <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00>, <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00>, <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00>, <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00>, <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00>, <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00>, <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00>, <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00>, <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00>, <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00>, <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00>, <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00>, <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00>, <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00>, <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00>, <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00>, <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00>, <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00>, <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00>, <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00>, <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00>, <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00>, <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00>, <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00>, <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00>, <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00>, <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00>, <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00>, <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00>, <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00>, <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00>, <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00>, <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00>, <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00>, <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00>, <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00>, <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00>, <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00>, <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00>, <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00>, <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00>, <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00>, <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00>, <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00>, <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00>, <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00>, <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00>, <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00>, <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00>, <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00>, <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00>, <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00>, <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00>, <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00>, <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <0.31, 0.98, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <0.31, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <0.31, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <0.23, 1.03, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <0.23, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <0.31, 0.98, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <0.23, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <0.18, 1.11, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <0.18, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <0.23, 1.03, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <0.18, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <0.16, 1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.16, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.18, 1.11, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.16, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.18, 1.29, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <0.18, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <0.16, 1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <0.18, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <0.23, 1.37, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <0.23, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <0.18, 1.29, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <0.23, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <0.31, 1.42, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <0.31, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <0.23, 1.37, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <0.31, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <0.31, 1.42, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <0.49, 1.42, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, 1.42, -0.00>, <0.38, 0.92, 0.00>, <0.49, 1.42, 0.16>, <0.38, 0.92, 0.00>, <0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, 1.42, 0.16>, <0.38, 0.92, 0.00>, <0.49, 1.42, -0.00>, <0.38, 0.92, 0.00>, <0.57, 1.37, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, 1.37, -0.00>, <0.70, 0.70, 0.00>, <0.57, 1.37, 0.16>, <0.70, 0.70, 0.00>, <0.49, 1.42, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, 1.37, 0.16>, <0.70, 0.70, 0.00>, <0.57, 1.37, -0.00>, <0.70, 0.70, 0.00>, <0.62, 1.29, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, 1.29, -0.00>, <0.92, 0.38, 0.00>, <0.62, 1.29, 0.16>, <0.92, 0.38, 0.00>, <0.57, 1.37, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, 1.29, 0.16>, <0.92, 0.38, 0.00>, <0.62, 1.29, -0.00>, <0.92, 0.38, 0.00>, <0.64, 1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, 1.20, -0.00>, <1.00, -0.00, 0.00>, <0.64, 1.20, 0.16>, <1.00, -0.00, 0.00>, <0.62, 1.29, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, 1.20, 0.16>, <1.00, -0.00, 0.00>, <0.64, 1.20, -0.00>, <1.00, -0.00, 0.00>, <0.62, 1.11, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, 1.11, -0.00>, <0.92, -0.38, 0.00>, <0.62, 1.11, 0.16>, <0.92, -0.38, 0.00>, <0.64, 1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, 1.11, 0.16>, <0.92, -0.38, 0.00>, <0.62, 1.11, -0.00>, <0.92, -0.38, 0.00>, <0.57, 1.03, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, 1.03, -0.00>, <0.70, -0.70, 0.00>, <0.57, 1.03, 0.16>, <0.70, -0.70, 0.00>, <0.62, 1.11, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, 1.03, 0.16>, <0.70, -0.70, 0.00>, <0.57, 1.03, -0.00>, <0.70, -0.70, 0.00>, <0.49, 0.98, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, 0.98, -0.00>, <0.38, -0.92, 0.00>, <0.49, 0.98, 0.16>, <0.38, -0.92, 0.00>, <0.57, 1.03, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, 0.98, 0.16>, <0.38, -0.92, 0.00>, <0.49, 0.98, -0.00>, <0.38, -0.92, 0.00>, <0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <0.49, 0.98, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.76, 0.16>, <-0.00, -1.00, 0.00>, <0.40, 1.76, -0.00>, <-0.00, -1.00, 0.00>, <0.31, 1.78, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, 1.78, -0.00>, <-0.38, -0.92, 0.00>, <0.31, 1.78, 0.16>, <-0.38, -0.92, 0.00>, <0.40, 1.76, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, 1.78, 0.16>, <-0.38, -0.92, 0.00>, <0.31, 1.78, -0.00>, <-0.38, -0.92, 0.00>, <0.23, 1.83, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 1.83, -0.00>, <-0.70, -0.70, 0.00>, <0.23, 1.83, 0.16>, <-0.70, -0.70, 0.00>, <0.31, 1.78, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, 1.83, 0.16>, <-0.70, -0.70, 0.00>, <0.23, 1.83, -0.00>, <-0.70, -0.70, 0.00>, <0.18, 1.91, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, 1.91, -0.00>, <-0.92, -0.38, 0.00>, <0.18, 1.91, 0.16>, <-0.92, -0.38, 0.00>, <0.23, 1.83, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, 1.91, 0.16>, <-0.92, -0.38, 0.00>, <0.18, 1.91, -0.00>, <-0.92, -0.38, 0.00>, <0.16, 2.00, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, 2.00, -0.00>, <-1.00, -0.00, 0.00>, <0.16, 2.00, 0.16>, <-1.00, -0.00, 0.00>, <0.18, 1.91, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, 2.00, 0.16>, <-1.00, -0.00, 0.00>, <0.16, 2.00, -0.00>, <-1.00, -0.00, 0.00>, <0.18, 2.09, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, 2.09, -0.00>, <-0.92, 0.38, 0.00>, <0.18, 2.09, 0.16>, <-0.92, 0.38, 0.00>, <0.16, 2.00, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, 2.09, 0.16>, <-0.92, 0.38, 0.00>, <0.18, 2.09, -0.00>, <-0.92, 0.38, 0.00>, <0.23, 2.17, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 2.17, -0.00>, <-0.70, 0.70, 0.00>, <0.23, 2.17, 0.16>, <-0.70, 0.70, 0.00>, <0.18, 2.09, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, 2.17, 0.16>, <-0.70, 0.70, 0.00>, <0.23, 2.17, -0.00>, <-0.70, 0.70, 0.00>, <0.31, 2.22, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, 2.22, -0.00>, <-0.38, 0.92, 0.00>, <0.31, 2.22, 0.16>, <-0.38, 0.92, 0.00>, <0.23, 2.17, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, 2.22, 0.16>, <-0.38, 0.92, 0.00>, <0.31, 2.22, -0.00>, <-0.38, 0.92, 0.00>, <0.40, 2.24, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, 2.24, -0.00>, <-0.00, 1.00, 0.00>, <0.40, 2.24, 0.16>, <-0.00, 1.00, 0.00>, <0.31, 2.22, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, 2.24, 0.16>, <-0.00, 1.00, 0.00>, <0.40, 2.24, -0.00>, <-0.00, 1.00, 0.00>, <0.49, 2.22, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, 2.22, -0.00>, <0.38, 0.92, 0.00>, <0.49, 2.22, 0.16>, <0.38, 0.92, 0.00>, <0.40, 2.24, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, 2.22, 0.16>, <0.38, 0.92, 0.00>, <0.49, 2.22, -0.00>, <0.38, 0.92, 0.00>, <0.57, 2.17, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, 2.17, -0.00>, <0.70, 0.70, 0.00>, <0.57, 2.17, 0.16>, <0.70, 0.70, 0.00>, <0.49, 2.22, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, 2.17, 0.16>, <0.70, 0.70, 0.00>, <0.57, 2.17, -0.00>, <0.70, 0.70, 0.00>, <0.62, 2.09, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, 2.09, -0.00>, <0.92, 0.38, 0.00>, <0.62, 2.09, 0.16>, <0.92, 0.38, 0.00>, <0.57, 2.17, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, 2.09, 0.16>, <0.92, 0.38, 0.00>, <0.62, 2.09, -0.00>, <0.92, 0.38, 0.00>, <0.64, 2.00, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, 2.00, -0.00>, <1.00, -0.00, 0.00>, <0.64, 2.00, 0.16>, <1.00, -0.00, 0.00>, <0.62, 2.09, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, 2.00, 0.16>, <1.00, -0.00, 0.00>, <0.64, 2.00, -0.00>, <1.00, -0.00, 0.00>, <0.62, 1.91, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, 1.91, -0.00>, <0.92, -0.38, 0.00>, <0.62, 1.91, 0.16>, <0.92, -0.38, 0.00>, <0.64, 2.00, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, 1.91, 0.16>, <0.92, -0.38, 0.00>, <0.62, 1.91, -0.00>, <0.92, -0.38, 0.00>, <0.57, 1.83, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, 1.83, -0.00>, <0.70, -0.70, 0.00>, <0.57, 1.83, 0.16>, <0.70, -0.70, 0.00>, <0.62, 1.91, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, 1.83, 0.16>, <0.70, -0.70, 0.00>, <0.57, 1.83, -0.00>, <0.70, -0.70, 0.00>, <0.49, 1.78, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, 1.78, -0.00>, <0.38, -0.92, 0.00>, <0.49, 1.78, 0.16>, <0.38, -0.92, 0.00>, <0.57, 1.83, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, 1.78, 0.16>, <0.38, -0.92, 0.00>, <0.49, 1.78, -0.00>, <0.38, -0.92, 0.00>, <0.40, 1.76, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, 1.76, -0.00>, <-0.00, -1.00, 0.00>, <0.40, 1.76, 0.16>, <-0.00, -1.00, 0.00>, <0.49, 1.78, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 1.76, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 1.78, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.83, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.91, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 2.09, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 2.17, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 2.22, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 2.24, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 2.24, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 2.22, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 2.22, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 2.17, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 2.17, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 2.09, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 2.09, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 2.00, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.91, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.91, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.83, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.83, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 1.78, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 2.00, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 1.78, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 1.76, 0.16>, <-0.00, -0.00, 1.00> }
}

#declare lc_2456_dat_clear = lc_2456_dat

#declare lc_3001_dat = mesh {
  smooth_triangle { <-0.09, -1.02, -0.96>, <0.38, 0.92, 0.00>, <-0.00, -1.04, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -1.04, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.04, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, -1.02, -0.16>, <0.38, 0.92, 0.00>, <-0.09, -1.02, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, -0.97, -0.96>, <0.70, 0.70, 0.00>, <-0.09, -1.02, -0.96>, <0.38, 0.92, 0.00>, <-0.09, -1.02, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, -1.02, -0.16>, <0.38, 0.92, 0.00>, <-0.17, -0.97, -0.16>, <0.70, 0.70, 0.00>, <-0.17, -0.97, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, -0.89, -0.96>, <0.92, 0.38, 0.00>, <-0.17, -0.97, -0.96>, <0.70, 0.70, 0.00>, <-0.17, -0.97, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, -0.97, -0.16>, <0.70, 0.70, 0.00>, <-0.22, -0.89, -0.16>, <0.92, 0.38, 0.00>, <-0.22, -0.89, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, -0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.22, -0.89, -0.96>, <0.92, 0.38, 0.00>, <-0.22, -0.89, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, -0.89, -0.16>, <0.92, 0.38, 0.00>, <-0.24, -0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.24, -0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, -0.71, -0.96>, <0.92, -0.38, 0.00>, <-0.24, -0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.24, -0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, -0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.22, -0.71, -0.16>, <0.92, -0.38, 0.00>, <-0.22, -0.71, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, -0.63, -0.96>, <0.70, -0.70, 0.00>, <-0.22, -0.71, -0.96>, <0.92, -0.38, 0.00>, <-0.22, -0.71, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, -0.71, -0.16>, <0.92, -0.38, 0.00>, <-0.17, -0.63, -0.16>, <0.70, -0.70, 0.00>, <-0.17, -0.63, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, -0.58, -0.96>, <0.38, -0.92, 0.00>, <-0.17, -0.63, -0.96>, <0.70, -0.70, 0.00>, <-0.17, -0.63, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, -0.63, -0.16>, <0.70, -0.70, 0.00>, <-0.09, -0.58, -0.16>, <0.38, -0.92, 0.00>, <-0.09, -0.58, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, -0.56, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, -0.58, -0.96>, <0.38, -0.92, 0.00>, <-0.09, -0.58, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, -0.58, -0.16>, <0.38, -0.92, 0.00>, <-0.00, -0.56, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -0.56, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, -0.58, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, -0.56, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -0.56, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -0.56, -0.16>, <-0.00, -1.00, 0.00>, <0.09, -0.58, -0.16>, <-0.38, -0.92, 0.00>, <0.09, -0.58, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, -0.63, -0.96>, <-0.70, -0.70, 0.00>, <0.09, -0.58, -0.96>, <-0.38, -0.92, 0.00>, <0.09, -0.58, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, -0.58, -0.16>, <-0.38, -0.92, 0.00>, <0.17, -0.63, -0.16>, <-0.70, -0.70, 0.00>, <0.17, -0.63, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, -0.71, -0.96>, <-0.92, -0.38, 0.00>, <0.17, -0.63, -0.96>, <-0.70, -0.70, 0.00>, <0.17, -0.63, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, -0.63, -0.16>, <-0.70, -0.70, 0.00>, <0.22, -0.71, -0.16>, <-0.92, -0.38, 0.00>, <0.22, -0.71, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.22, -0.71, -0.96>, <-0.92, -0.38, 0.00>, <0.22, -0.71, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, -0.71, -0.16>, <-0.92, -0.38, 0.00>, <0.24, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.24, -0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, -0.89, -0.96>, <-0.92, 0.38, 0.00>, <0.24, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.24, -0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.22, -0.89, -0.16>, <-0.92, 0.38, 0.00>, <0.22, -0.89, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, -0.97, -0.96>, <-0.70, 0.70, 0.00>, <0.22, -0.89, -0.96>, <-0.92, 0.38, 0.00>, <0.22, -0.89, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, -0.89, -0.16>, <-0.92, 0.38, 0.00>, <0.17, -0.97, -0.16>, <-0.70, 0.70, 0.00>, <0.17, -0.97, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, -1.02, -0.96>, <-0.38, 0.92, 0.00>, <0.17, -0.97, -0.96>, <-0.70, 0.70, 0.00>, <0.17, -0.97, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, -0.97, -0.16>, <-0.70, 0.70, 0.00>, <0.09, -1.02, -0.16>, <-0.38, 0.92, 0.00>, <0.09, -1.02, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -1.04, -0.96>, <-0.00, 1.00, 0.00>, <0.09, -1.02, -0.96>, <-0.38, 0.92, 0.00>, <0.09, -1.02, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, -1.02, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, -1.04, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -1.04, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -1.12, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -1.12, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, -1.10, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, -1.10, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, -1.10, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, -1.12, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, -1.10, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, -1.10, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, -1.03, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -1.03, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, -1.03, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, -1.10, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, -1.03, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, -1.03, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, -0.92, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, -0.92, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, -0.92, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, -1.03, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, -0.92, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, -0.92, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, -0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, -0.92, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, -0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, -0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, -0.68, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, -0.68, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, -0.68, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, -0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, -0.68, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, -0.68, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, -0.57, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, -0.57, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, -0.68, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, -0.57, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, -0.50, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, -0.50, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, -0.50, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, -0.57, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, -0.50, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, -0.50, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, -0.48, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.48, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -0.48, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, -0.50, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -0.48, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -0.48, -0.96>, <-0.00, 1.00, 0.00>, <0.12, -0.50, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, -0.50, -0.96>, <0.38, 0.92, 0.00>, <0.12, -0.50, -0.16>, <0.38, 0.92, 0.00>, <-0.00, -0.48, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, -0.50, -0.16>, <0.38, 0.92, 0.00>, <0.12, -0.50, -0.96>, <0.38, 0.92, 0.00>, <0.23, -0.57, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.96>, <0.70, 0.70, 0.00>, <0.23, -0.57, -0.16>, <0.70, 0.70, 0.00>, <0.12, -0.50, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.16>, <0.70, 0.70, 0.00>, <0.23, -0.57, -0.96>, <0.70, 0.70, 0.00>, <0.30, -0.68, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, -0.68, -0.96>, <0.92, 0.38, 0.00>, <0.30, -0.68, -0.16>, <0.92, 0.38, 0.00>, <0.23, -0.57, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, -0.68, -0.16>, <0.92, 0.38, 0.00>, <0.30, -0.68, -0.96>, <0.92, 0.38, 0.00>, <0.32, -0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, -0.80, -0.96>, <1.00, -0.00, 0.00>, <0.32, -0.80, -0.16>, <1.00, -0.00, 0.00>, <0.30, -0.68, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, -0.80, -0.16>, <1.00, -0.00, 0.00>, <0.32, -0.80, -0.96>, <1.00, -0.00, 0.00>, <0.30, -0.92, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, -0.92, -0.96>, <0.92, -0.38, 0.00>, <0.30, -0.92, -0.16>, <0.92, -0.38, 0.00>, <0.32, -0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, -0.92, -0.16>, <0.92, -0.38, 0.00>, <0.30, -0.92, -0.96>, <0.92, -0.38, 0.00>, <0.23, -1.03, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -1.03, -0.96>, <0.70, -0.70, 0.00>, <0.23, -1.03, -0.16>, <0.70, -0.70, 0.00>, <0.30, -0.92, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, -1.03, -0.16>, <0.70, -0.70, 0.00>, <0.23, -1.03, -0.96>, <0.70, -0.70, 0.00>, <0.12, -1.10, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, -1.10, -0.96>, <0.38, -0.92, 0.00>, <0.12, -1.10, -0.16>, <0.38, -0.92, 0.00>, <0.23, -1.03, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, -1.10, -0.16>, <0.38, -0.92, 0.00>, <0.12, -1.10, -0.96>, <0.38, -0.92, 0.00>, <-0.00, -1.12, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -1.12, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -1.12, -0.16>, <-0.00, -1.00, 0.00>, <0.12, -1.10, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.56, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.56, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.56, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.50, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -0.58, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.12, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.04, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -1.04, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -1.04, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00>, <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00>, <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00>, <-0.09, -0.22, -0.96>, <0.38, 0.92, 0.00>, <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, -0.22, -0.16>, <0.38, 0.92, 0.00>, <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00>, <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00>, <-0.17, -0.17, -0.96>, <0.70, 0.70, 0.00>, <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, -0.17, -0.16>, <0.70, 0.70, 0.00>, <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00>, <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00>, <-0.22, -0.09, -0.96>, <0.92, 0.38, 0.00>, <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, -0.09, -0.16>, <0.92, 0.38, 0.00>, <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00>, <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00>, <-0.24, -0.00, -0.96>, <1.00, -0.00, 0.00>, <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, -0.00, -0.16>, <1.00, -0.00, 0.00>, <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00>, <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00>, <-0.22, 0.09, -0.96>, <0.92, -0.38, 0.00>, <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, 0.09, -0.16>, <0.92, -0.38, 0.00>, <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00>, <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00>, <-0.17, 0.17, -0.96>, <0.70, -0.70, 0.00>, <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, 0.17, -0.16>, <0.70, -0.70, 0.00>, <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00>, <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, 0.22, -0.96>, <0.38, -0.92, 0.00>, <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, 0.22, -0.16>, <0.38, -0.92, 0.00>, <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, 0.24, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 0.24, -0.16>, <-0.00, -1.00, 0.00>, <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00>, <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00>, <0.09, 0.22, -0.96>, <-0.38, -0.92, 0.00>, <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, 0.22, -0.16>, <-0.38, -0.92, 0.00>, <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00>, <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00>, <0.17, 0.17, -0.96>, <-0.70, -0.70, 0.00>, <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, 0.17, -0.16>, <-0.70, -0.70, 0.00>, <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00>, <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <0.22, 0.09, -0.96>, <-0.92, -0.38, 0.00>, <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, 0.09, -0.16>, <-0.92, -0.38, 0.00>, <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00>, <0.24, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00>, <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00>, <0.22, -0.09, -0.96>, <-0.92, 0.38, 0.00>, <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, -0.09, -0.16>, <-0.92, 0.38, 0.00>, <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00>, <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00>, <0.17, -0.17, -0.96>, <-0.70, 0.70, 0.00>, <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, -0.17, -0.16>, <-0.70, 0.70, 0.00>, <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00>, <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00>, <0.09, -0.22, -0.96>, <-0.38, 0.92, 0.00>, <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, -0.22, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, -0.24, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, -0.24, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, -0.30, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, -0.30, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, -0.23, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, -0.23, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, -0.12, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, -0.12, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, -0.00, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, -0.00, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, 0.12, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, 0.12, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, 0.23, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, 0.23, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, 0.30, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, 0.30, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 0.32, -0.96>, <-0.00, 1.00, 0.00>, <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00>, <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00>, <-0.00, 0.32, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00>, <0.12, 0.30, -0.96>, <0.38, 0.92, 0.00>, <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00>, <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00>, <0.12, 0.30, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00>, <0.23, 0.23, -0.96>, <0.70, 0.70, 0.00>, <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00>, <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00>, <0.23, 0.23, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00>, <0.30, 0.12, -0.96>, <0.92, 0.38, 0.00>, <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00>, <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00>, <0.30, 0.12, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00>, <0.32, -0.00, -0.96>, <1.00, -0.00, 0.00>, <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00>, <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00>, <0.32, -0.00, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00>, <0.30, -0.12, -0.96>, <0.92, -0.38, 0.00>, <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00>, <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00>, <0.30, -0.12, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00>, <0.23, -0.23, -0.96>, <0.70, -0.70, 0.00>, <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00>, <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00>, <0.23, -0.23, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00>, <0.12, -0.30, -0.96>, <0.38, -0.92, 0.00>, <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, -0.32, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, -0.32, -0.16>, <-0.00, -1.00, 0.00>, <0.12, -0.30, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.24, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00>, <0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.32, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, -0.24, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, -0.30, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, -0.22, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, -0.23, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, -0.17, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, -0.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, -0.09, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, -0.00, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, -0.00, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.58, -0.96>, <0.38, 0.92, 0.00>, <-0.00, 0.56, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 0.56, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.56, -0.16>, <-0.00, 1.00, 0.00>, <-0.09, 0.58, -0.16>, <0.38, 0.92, 0.00>, <-0.09, 0.58, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.17, 0.63, -0.96>, <0.70, 0.70, 0.00>, <-0.09, 0.58, -0.96>, <0.38, 0.92, 0.00>, <-0.09, 0.58, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.09, 0.58, -0.16>, <0.38, 0.92, 0.00>, <-0.17, 0.63, -0.16>, <0.70, 0.70, 0.00>, <-0.17, 0.63, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.22, 0.71, -0.96>, <0.92, 0.38, 0.00>, <-0.17, 0.63, -0.96>, <0.70, 0.70, 0.00>, <-0.17, 0.63, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.17, 0.63, -0.16>, <0.70, 0.70, 0.00>, <-0.22, 0.71, -0.16>, <0.92, 0.38, 0.00>, <-0.22, 0.71, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.24, 0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.22, 0.71, -0.96>, <0.92, 0.38, 0.00>, <-0.22, 0.71, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.22, 0.71, -0.16>, <0.92, 0.38, 0.00>, <-0.24, 0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.24, 0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.22, 0.89, -0.96>, <0.92, -0.38, 0.00>, <-0.24, 0.80, -0.96>, <1.00, -0.00, 0.00>, <-0.24, 0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.24, 0.80, -0.16>, <1.00, -0.00, 0.00>, <-0.22, 0.89, -0.16>, <0.92, -0.38, 0.00>, <-0.22, 0.89, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.17, 0.97, -0.96>, <0.70, -0.70, 0.00>, <-0.22, 0.89, -0.96>, <0.92, -0.38, 0.00>, <-0.22, 0.89, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.22, 0.89, -0.16>, <0.92, -0.38, 0.00>, <-0.17, 0.97, -0.16>, <0.70, -0.70, 0.00>, <-0.17, 0.97, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.09, 1.02, -0.96>, <0.38, -0.92, 0.00>, <-0.17, 0.97, -0.96>, <0.70, -0.70, 0.00>, <-0.17, 0.97, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.17, 0.97, -0.16>, <0.70, -0.70, 0.00>, <-0.09, 1.02, -0.16>, <0.38, -0.92, 0.00>, <-0.09, 1.02, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.00, 1.04, -0.96>, <-0.00, -1.00, 0.00>, <-0.09, 1.02, -0.96>, <0.38, -0.92, 0.00>, <-0.09, 1.02, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.09, 1.02, -0.16>, <0.38, -0.92, 0.00>, <-0.00, 1.04, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 1.04, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.09, 1.02, -0.96>, <-0.38, -0.92, 0.00>, <-0.00, 1.04, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 1.04, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 1.04, -0.16>, <-0.00, -1.00, 0.00>, <0.09, 1.02, -0.16>, <-0.38, -0.92, 0.00>, <0.09, 1.02, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.17, 0.97, -0.96>, <-0.70, -0.70, 0.00>, <0.09, 1.02, -0.96>, <-0.38, -0.92, 0.00>, <0.09, 1.02, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.09, 1.02, -0.16>, <-0.38, -0.92, 0.00>, <0.17, 0.97, -0.16>, <-0.70, -0.70, 0.00>, <0.17, 0.97, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.22, 0.89, -0.96>, <-0.92, -0.38, 0.00>, <0.17, 0.97, -0.96>, <-0.70, -0.70, 0.00>, <0.17, 0.97, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.17, 0.97, -0.16>, <-0.70, -0.70, 0.00>, <0.22, 0.89, -0.16>, <-0.92, -0.38, 0.00>, <0.22, 0.89, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.24, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.22, 0.89, -0.96>, <-0.92, -0.38, 0.00>, <0.22, 0.89, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.22, 0.89, -0.16>, <-0.92, -0.38, 0.00>, <0.24, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.24, 0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.22, 0.71, -0.96>, <-0.92, 0.38, 0.00>, <0.24, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <0.24, 0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.24, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <0.22, 0.71, -0.16>, <-0.92, 0.38, 0.00>, <0.22, 0.71, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.17, 0.63, -0.96>, <-0.70, 0.70, 0.00>, <0.22, 0.71, -0.96>, <-0.92, 0.38, 0.00>, <0.22, 0.71, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.22, 0.71, -0.16>, <-0.92, 0.38, 0.00>, <0.17, 0.63, -0.16>, <-0.70, 0.70, 0.00>, <0.17, 0.63, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.09, 0.58, -0.96>, <-0.38, 0.92, 0.00>, <0.17, 0.63, -0.96>, <-0.70, 0.70, 0.00>, <0.17, 0.63, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.17, 0.63, -0.16>, <-0.70, 0.70, 0.00>, <0.09, 0.58, -0.16>, <-0.38, 0.92, 0.00>, <0.09, 0.58, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 0.56, -0.96>, <-0.00, 1.00, 0.00>, <0.09, 0.58, -0.96>, <-0.38, 0.92, 0.00>, <0.09, 0.58, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.09, 0.58, -0.16>, <-0.38, 0.92, 0.00>, <-0.00, 0.56, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 0.56, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 0.48, -0.16>, <-0.00, -1.00, 0.00>, <-0.00, 0.48, -0.96>, <-0.00, -1.00, 0.00>, <-0.12, 0.50, -0.96>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.12, 0.50, -0.96>, <-0.38, -0.92, 0.00>, <-0.12, 0.50, -0.16>, <-0.38, -0.92, 0.00>, <-0.00, 0.48, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.12, 0.50, -0.16>, <-0.38, -0.92, 0.00>, <-0.12, 0.50, -0.96>, <-0.38, -0.92, 0.00>, <-0.23, 0.57, -0.96>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.96>, <-0.70, -0.70, 0.00>, <-0.23, 0.57, -0.16>, <-0.70, -0.70, 0.00>, <-0.12, 0.50, -0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.16>, <-0.70, -0.70, 0.00>, <-0.23, 0.57, -0.96>, <-0.70, -0.70, 0.00>, <-0.30, 0.68, -0.96>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.30, 0.68, -0.96>, <-0.92, -0.38, 0.00>, <-0.30, 0.68, -0.16>, <-0.92, -0.38, 0.00>, <-0.23, 0.57, -0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.30, 0.68, -0.16>, <-0.92, -0.38, 0.00>, <-0.30, 0.68, -0.96>, <-0.92, -0.38, 0.00>, <-0.32, 0.80, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.32, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.32, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.30, 0.68, -0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.32, 0.80, -0.16>, <-1.00, -0.00, 0.00>, <-0.32, 0.80, -0.96>, <-1.00, -0.00, 0.00>, <-0.30, 0.92, -0.96>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.30, 0.92, -0.96>, <-0.92, 0.38, 0.00>, <-0.30, 0.92, -0.16>, <-0.92, 0.38, 0.00>, <-0.32, 0.80, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.30, 0.92, -0.16>, <-0.92, 0.38, 0.00>, <-0.30, 0.92, -0.96>, <-0.92, 0.38, 0.00>, <-0.23, 1.03, -0.96>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 1.03, -0.96>, <-0.70, 0.70, 0.00>, <-0.23, 1.03, -0.16>, <-0.70, 0.70, 0.00>, <-0.30, 0.92, -0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.23, 1.03, -0.16>, <-0.70, 0.70, 0.00>, <-0.23, 1.03, -0.96>, <-0.70, 0.70, 0.00>, <-0.12, 1.10, -0.96>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.12, 1.10, -0.96>, <-0.38, 0.92, 0.00>, <-0.12, 1.10, -0.16>, <-0.38, 0.92, 0.00>, <-0.23, 1.03, -0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.12, 1.10, -0.16>, <-0.38, 0.92, 0.00>, <-0.12, 1.10, -0.96>, <-0.38, 0.92, 0.00>, <-0.00, 1.12, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.00, 1.12, -0.96>, <-0.00, 1.00, 0.00>, <-0.00, 1.12, -0.16>, <-0.00, 1.00, 0.00>, <-0.12, 1.10, -0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.00, 1.12, -0.16>, <-0.00, 1.00, 0.00>, <-0.00, 1.12, -0.96>, <-0.00, 1.00, 0.00>, <0.12, 1.10, -0.96>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.12, 1.10, -0.96>, <0.38, 0.92, 0.00>, <0.12, 1.10, -0.16>, <0.38, 0.92, 0.00>, <-0.00, 1.12, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.12, 1.10, -0.16>, <0.38, 0.92, 0.00>, <0.12, 1.10, -0.96>, <0.38, 0.92, 0.00>, <0.23, 1.03, -0.96>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 1.03, -0.96>, <0.70, 0.70, 0.00>, <0.23, 1.03, -0.16>, <0.70, 0.70, 0.00>, <0.12, 1.10, -0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.23, 1.03, -0.16>, <0.70, 0.70, 0.00>, <0.23, 1.03, -0.96>, <0.70, 0.70, 0.00>, <0.30, 0.92, -0.96>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.30, 0.92, -0.96>, <0.92, 0.38, 0.00>, <0.30, 0.92, -0.16>, <0.92, 0.38, 0.00>, <0.23, 1.03, -0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.30, 0.92, -0.16>, <0.92, 0.38, 0.00>, <0.30, 0.92, -0.96>, <0.92, 0.38, 0.00>, <0.32, 0.80, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.32, 0.80, -0.96>, <1.00, -0.00, 0.00>, <0.32, 0.80, -0.16>, <1.00, -0.00, 0.00>, <0.30, 0.92, -0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.32, 0.80, -0.16>, <1.00, -0.00, 0.00>, <0.32, 0.80, -0.96>, <1.00, -0.00, 0.00>, <0.30, 0.68, -0.96>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.30, 0.68, -0.96>, <0.92, -0.38, 0.00>, <0.30, 0.68, -0.16>, <0.92, -0.38, 0.00>, <0.32, 0.80, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.30, 0.68, -0.16>, <0.92, -0.38, 0.00>, <0.30, 0.68, -0.96>, <0.92, -0.38, 0.00>, <0.23, 0.57, -0.96>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.96>, <0.70, -0.70, 0.00>, <0.23, 0.57, -0.16>, <0.70, -0.70, 0.00>, <0.30, 0.68, -0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.16>, <0.70, -0.70, 0.00>, <0.23, 0.57, -0.96>, <0.70, -0.70, 0.00>, <0.12, 0.50, -0.96>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.12, 0.50, -0.96>, <0.38, -0.92, 0.00>, <0.12, 0.50, -0.16>, <0.38, -0.92, 0.00>, <0.23, 0.57, -0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.12, 0.50, -0.16>, <0.38, -0.92, 0.00>, <0.12, 0.50, -0.96>, <0.38, -0.92, 0.00>, <-0.00, 0.48, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.00, 0.48, -0.96>, <-0.00, -1.00, 0.00>, <-0.00, 0.48, -0.16>, <-0.00, -1.00, 0.00>, <0.12, 0.50, -0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.04, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.12, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.12, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 1.04, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 1.04, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 1.10, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 1.02, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 1.03, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.97, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.92, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.89, -0.96>, <-0.00, -0.00, -1.00>, <0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.48, -0.96>, <-0.00, -0.00, -1.00>, <0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.56, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.48, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.48, -0.96>, <-0.00, -0.00, -1.00>, <-0.00, 0.56, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.00, 0.56, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.12, 0.50, -0.96>, <-0.00, -0.00, -1.00>, <-0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.09, 0.58, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.23, 0.57, -0.96>, <-0.00, -0.00, -1.00>, <-0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.17, 0.63, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.30, 0.68, -0.96>, <-0.00, -0.00, -1.00>, <-0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.22, 0.71, -0.96>, <-0.00, -0.00, -1.00>, <-0.24, 0.80, -0.96>, <-0.00, -0.00, -1.00>, <-0.32, 0.80, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, -1.44, -0.16>, <-0.00, -0.00, -1.00>, <0.64, 1.44, -0.16>, <-0.00, -0.00, -1.00>, <-0.64, 1.44, -0.16>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, 1.44, -0.16>, <-0.00, -0.00, -1.00>, <-0.64, -1.44, -0.16>, <-0.00, -0.00, -1.00>, <0.64, -1.44, -0.16>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, -1.44, -0.96>, <1.00, -0.00, 0.00>, <-0.64, -1.44, -0.16>, <1.00, -0.00, 0.00>, <-0.64, 1.44, -0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 1.44, -0.16>, <1.00, -0.00, 0.00>, <-0.64, 1.44, -0.96>, <1.00, -0.00, 0.00>, <-0.64, -1.44, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 1.44, -0.96>, <-0.00, -1.00, 0.00>, <-0.64, 1.44, -0.16>, <-0.00, -1.00, 0.00>, <0.64, 1.44, -0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.64, 1.44, -0.16>, <-0.00, -1.00, 0.00>, <0.64, 1.44, -0.96>, <-0.00, -1.00, 0.00>, <-0.64, 1.44, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.64, 1.44, -0.96>, <-1.00, -0.00, 0.00>, <0.64, 1.44, -0.16>, <-1.00, -0.00, 0.00>, <0.64, -1.44, -0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -1.44, -0.16>, <-1.00, -0.00, 0.00>, <0.64, -1.44, -0.96>, <-1.00, -0.00, 0.00>, <0.64, 1.44, -0.96>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -1.44, -0.96>, <-0.00, 1.00, 0.00>, <0.64, -1.44, -0.16>, <-0.00, 1.00, 0.00>, <-0.64, -1.44, -0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.64, -1.44, -0.16>, <-0.00, 1.00, 0.00>, <-0.64, -1.44, -0.96>, <-0.00, 1.00, 0.00>, <0.64, -1.44, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.64, 1.44, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, -1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, -1.44, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, 1.44, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, 1.44, -0.96>, <-0.00, -0.00, -1.00>, <0.80, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, 1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, 1.44, -0.96>, <-0.00, -0.00, -1.00>, <0.64, 1.44, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.64, -1.44, -0.96>, <-0.00, -0.00, -1.00>, <0.80, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.80, 1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.80, 1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.64, 1.44, -0.96>, <-0.00, -0.00, -1.00>, <0.64, -1.44, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.64, -1.44, -0.96>, <-0.00, -0.00, -1.00>, <-0.80, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.80, -1.60, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <0.80, -1.60, -0.96>, <-0.00, -0.00, -1.00>, <0.64, -1.44, -0.96>, <-0.00, -0.00, -1.00>, <-0.64, -1.44, -0.96>, <-0.00, -0.00, -1.00> }
  smooth_triangle { <-0.80, 1.60, -0.00>, <-0.00, -0.00, 1.00>, <0.80, 1.60, -0.00>, <-0.00, -0.00, 1.00>, <0.80, -1.60, -0.00>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.80, -1.60, -0.00>, <-0.00, -0.00, 1.00>, <-0.80, -1.60, -0.00>, <-0.00, -0.00, 1.00>, <-0.80, 1.60, -0.00>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.80, -1.60, -0.00>, <-0.00, -1.00, 0.00>, <0.80, -1.60, -0.00>, <-0.00, -1.00, 0.00>, <0.80, -1.60, -0.96>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.80, -1.60, -0.96>, <-0.00, -1.00, 0.00>, <-0.80, -1.60, -0.96>, <-0.00, -1.00, 0.00>, <-0.80, -1.60, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.80, 1.60, -0.00>, <-0.00, 1.00, 0.00>, <-0.80, 1.60, -0.00>, <-0.00, 1.00, 0.00>, <-0.80, 1.60, -0.96>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.80, 1.60, -0.96>, <-0.00, 1.00, 0.00>, <0.80, 1.60, -0.96>, <-0.00, 1.00, 0.00>, <0.80, 1.60, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, -1.42, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, -1.37, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, -1.42, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, -1.29, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, -1.37, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, -1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, -1.29, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, -1.11, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, -1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, -1.03, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, -1.11, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, -0.98, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, -1.03, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, -0.98, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, -0.98, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, -0.98, -0.00>, <0.38, 0.92, 0.00>, <-0.31, -0.98, 0.16>, <0.38, 0.92, 0.00>, <-0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, -0.98, 0.16>, <0.38, 0.92, 0.00>, <-0.31, -0.98, -0.00>, <0.38, 0.92, 0.00>, <-0.23, -1.03, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -1.03, -0.00>, <0.70, 0.70, 0.00>, <-0.23, -1.03, 0.16>, <0.70, 0.70, 0.00>, <-0.31, -0.98, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, -1.03, 0.16>, <0.70, 0.70, 0.00>, <-0.23, -1.03, -0.00>, <0.70, 0.70, 0.00>, <-0.18, -1.11, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, -1.11, -0.00>, <0.92, 0.38, 0.00>, <-0.18, -1.11, 0.16>, <0.92, 0.38, 0.00>, <-0.23, -1.03, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, -1.11, 0.16>, <0.92, 0.38, 0.00>, <-0.18, -1.11, -0.00>, <0.92, 0.38, 0.00>, <-0.16, -1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, -1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.16, -1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.18, -1.11, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, -1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.16, -1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.18, -1.29, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, -1.29, -0.00>, <0.92, -0.38, 0.00>, <-0.18, -1.29, 0.16>, <0.92, -0.38, 0.00>, <-0.16, -1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, -1.29, 0.16>, <0.92, -0.38, 0.00>, <-0.18, -1.29, -0.00>, <0.92, -0.38, 0.00>, <-0.23, -1.37, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -1.37, -0.00>, <0.70, -0.70, 0.00>, <-0.23, -1.37, 0.16>, <0.70, -0.70, 0.00>, <-0.18, -1.29, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, -1.37, 0.16>, <0.70, -0.70, 0.00>, <-0.23, -1.37, -0.00>, <0.70, -0.70, 0.00>, <-0.31, -1.42, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, -1.42, -0.00>, <0.38, -0.92, 0.00>, <-0.31, -1.42, 0.16>, <0.38, -0.92, 0.00>, <-0.23, -1.37, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, -1.42, 0.16>, <0.38, -0.92, 0.00>, <-0.31, -1.42, -0.00>, <0.38, -0.92, 0.00>, <-0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, -1.42, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, -0.62, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, -0.57, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, -0.49, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, -0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, -0.31, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, -0.23, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, -0.18, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00>, <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00>, <-0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00>, <-0.31, -0.18, -0.00>, <0.38, 0.92, 0.00>, <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00>, <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00>, <-0.31, -0.18, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00>, <-0.23, -0.23, -0.00>, <0.70, 0.70, 0.00>, <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00>, <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00>, <-0.23, -0.23, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00>, <-0.18, -0.31, -0.00>, <0.92, 0.38, 0.00>, <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.18, -0.31, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.16, -0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00>, <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00>, <-0.16, -0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00>, <-0.18, -0.49, -0.00>, <0.92, -0.38, 0.00>, <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00>, <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00>, <-0.18, -0.49, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00>, <-0.23, -0.57, -0.00>, <0.70, -0.70, 0.00>, <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00>, <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00>, <-0.23, -0.57, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00>, <-0.31, -0.62, -0.00>, <0.38, -0.92, 0.00>, <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, -0.62, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, 0.18, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, 0.23, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, 0.31, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, 0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, 0.49, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, 0.57, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, 0.62, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00>, <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00>, <-0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00>, <-0.31, 0.62, -0.00>, <0.38, 0.92, 0.00>, <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00>, <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00>, <-0.31, 0.62, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00>, <-0.23, 0.57, -0.00>, <0.70, 0.70, 0.00>, <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00>, <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00>, <-0.23, 0.57, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00>, <-0.18, 0.49, -0.00>, <0.92, 0.38, 0.00>, <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.18, 0.49, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00>, <-0.16, 0.40, -0.00>, <1.00, -0.00, 0.00>, <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00>, <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00>, <-0.16, 0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00>, <-0.18, 0.31, -0.00>, <0.92, -0.38, 0.00>, <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00>, <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00>, <-0.18, 0.31, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00>, <-0.23, 0.23, -0.00>, <0.70, -0.70, 0.00>, <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00>, <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00>, <-0.23, 0.23, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00>, <-0.31, 0.18, -0.00>, <0.38, -0.92, 0.00>, <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, 0.18, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <-0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <-0.49, 0.98, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.49, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <-0.49, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <-0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.49, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <-0.49, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <-0.57, 1.03, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.57, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <-0.57, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <-0.49, 0.98, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <-0.57, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <-0.57, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <-0.62, 1.11, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.62, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <-0.62, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <-0.57, 1.03, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <-0.62, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <-0.62, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <-0.64, 1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.64, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.64, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.62, 1.11, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <-0.64, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <-0.64, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <-0.62, 1.29, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.62, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <-0.62, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <-0.64, 1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.62, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <-0.62, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <-0.57, 1.37, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.57, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <-0.57, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <-0.62, 1.29, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <-0.57, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <-0.57, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <-0.49, 1.42, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.49, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <-0.49, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <-0.57, 1.37, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <-0.49, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <-0.49, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <-0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <-0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <-0.49, 1.42, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <-0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <-0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <-0.31, 1.42, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.31, 1.42, -0.00>, <0.38, 0.92, 0.00>, <-0.31, 1.42, 0.16>, <0.38, 0.92, 0.00>, <-0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <-0.31, 1.42, 0.16>, <0.38, 0.92, 0.00>, <-0.31, 1.42, -0.00>, <0.38, 0.92, 0.00>, <-0.23, 1.37, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.23, 1.37, -0.00>, <0.70, 0.70, 0.00>, <-0.23, 1.37, 0.16>, <0.70, 0.70, 0.00>, <-0.31, 1.42, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <-0.23, 1.37, 0.16>, <0.70, 0.70, 0.00>, <-0.23, 1.37, -0.00>, <0.70, 0.70, 0.00>, <-0.18, 1.29, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.18, 1.29, -0.00>, <0.92, 0.38, 0.00>, <-0.18, 1.29, 0.16>, <0.92, 0.38, 0.00>, <-0.23, 1.37, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <-0.18, 1.29, 0.16>, <0.92, 0.38, 0.00>, <-0.18, 1.29, -0.00>, <0.92, 0.38, 0.00>, <-0.16, 1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.16, 1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.16, 1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.18, 1.29, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <-0.16, 1.20, 0.16>, <1.00, -0.00, 0.00>, <-0.16, 1.20, -0.00>, <1.00, -0.00, 0.00>, <-0.18, 1.11, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.18, 1.11, -0.00>, <0.92, -0.38, 0.00>, <-0.18, 1.11, 0.16>, <0.92, -0.38, 0.00>, <-0.16, 1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.18, 1.11, 0.16>, <0.92, -0.38, 0.00>, <-0.18, 1.11, -0.00>, <0.92, -0.38, 0.00>, <-0.23, 1.03, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.23, 1.03, -0.00>, <0.70, -0.70, 0.00>, <-0.23, 1.03, 0.16>, <0.70, -0.70, 0.00>, <-0.18, 1.11, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <-0.23, 1.03, 0.16>, <0.70, -0.70, 0.00>, <-0.23, 1.03, -0.00>, <0.70, -0.70, 0.00>, <-0.31, 0.98, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.31, 0.98, -0.00>, <0.38, -0.92, 0.00>, <-0.31, 0.98, 0.16>, <0.38, -0.92, 0.00>, <-0.23, 1.03, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <-0.31, 0.98, 0.16>, <0.38, -0.92, 0.00>, <-0.31, 0.98, -0.00>, <0.38, -0.92, 0.00>, <-0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <-0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <-0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <-0.31, 0.98, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <-0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <-0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <-0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <0.31, -1.42, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <0.31, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, -1.42, 0.16>, <-0.38, -0.92, 0.00>, <0.31, -1.42, -0.00>, <-0.38, -0.92, 0.00>, <0.23, -1.37, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <0.23, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <0.31, -1.42, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, -1.37, 0.16>, <-0.70, -0.70, 0.00>, <0.23, -1.37, -0.00>, <-0.70, -0.70, 0.00>, <0.18, -1.29, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <0.18, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <0.23, -1.37, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, -1.29, 0.16>, <-0.92, -0.38, 0.00>, <0.18, -1.29, -0.00>, <-0.92, -0.38, 0.00>, <0.16, -1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.16, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.18, -1.29, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, -1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.16, -1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.18, -1.11, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <0.18, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <0.16, -1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, -1.11, 0.16>, <-0.92, 0.38, 0.00>, <0.18, -1.11, -0.00>, <-0.92, 0.38, 0.00>, <0.23, -1.03, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <0.23, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <0.18, -1.11, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, -1.03, 0.16>, <-0.70, 0.70, 0.00>, <0.23, -1.03, -0.00>, <-0.70, 0.70, 0.00>, <0.31, -0.98, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <0.31, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <0.23, -1.03, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, -0.98, 0.16>, <-0.38, 0.92, 0.00>, <0.31, -0.98, -0.00>, <-0.38, 0.92, 0.00>, <0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <0.31, -0.98, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00>, <0.40, -0.96, -0.00>, <-0.00, 1.00, 0.00>, <0.49, -0.98, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, -0.98, -0.00>, <0.38, 0.92, 0.00>, <0.49, -0.98, 0.16>, <0.38, 0.92, 0.00>, <0.40, -0.96, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, -0.98, 0.16>, <0.38, 0.92, 0.00>, <0.49, -0.98, -0.00>, <0.38, 0.92, 0.00>, <0.57, -1.03, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, -1.03, -0.00>, <0.70, 0.70, 0.00>, <0.57, -1.03, 0.16>, <0.70, 0.70, 0.00>, <0.49, -0.98, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, -1.03, 0.16>, <0.70, 0.70, 0.00>, <0.57, -1.03, -0.00>, <0.70, 0.70, 0.00>, <0.62, -1.11, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, -1.11, -0.00>, <0.92, 0.38, 0.00>, <0.62, -1.11, 0.16>, <0.92, 0.38, 0.00>, <0.57, -1.03, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, -1.11, 0.16>, <0.92, 0.38, 0.00>, <0.62, -1.11, -0.00>, <0.92, 0.38, 0.00>, <0.64, -1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -1.20, -0.00>, <1.00, -0.00, 0.00>, <0.64, -1.20, 0.16>, <1.00, -0.00, 0.00>, <0.62, -1.11, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, -1.20, 0.16>, <1.00, -0.00, 0.00>, <0.64, -1.20, -0.00>, <1.00, -0.00, 0.00>, <0.62, -1.29, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, -1.29, -0.00>, <0.92, -0.38, 0.00>, <0.62, -1.29, 0.16>, <0.92, -0.38, 0.00>, <0.64, -1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, -1.29, 0.16>, <0.92, -0.38, 0.00>, <0.62, -1.29, -0.00>, <0.92, -0.38, 0.00>, <0.57, -1.37, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, -1.37, -0.00>, <0.70, -0.70, 0.00>, <0.57, -1.37, 0.16>, <0.70, -0.70, 0.00>, <0.62, -1.29, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, -1.37, 0.16>, <0.70, -0.70, 0.00>, <0.57, -1.37, -0.00>, <0.70, -0.70, 0.00>, <0.49, -1.42, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, -1.42, -0.00>, <0.38, -0.92, 0.00>, <0.49, -1.42, 0.16>, <0.38, -0.92, 0.00>, <0.57, -1.37, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, -1.42, 0.16>, <0.38, -0.92, 0.00>, <0.49, -1.42, -0.00>, <0.38, -0.92, 0.00>, <0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, -1.44, -0.00>, <-0.00, -1.00, 0.00>, <0.40, -1.44, 0.16>, <-0.00, -1.00, 0.00>, <0.49, -1.42, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.96, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00>, <0.31, -0.62, -0.00>, <-0.38, -0.92, 0.00>, <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <0.31, -0.62, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00>, <0.23, -0.57, -0.00>, <-0.70, -0.70, 0.00>, <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <0.23, -0.57, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00>, <0.18, -0.49, -0.00>, <-0.92, -0.38, 0.00>, <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.18, -0.49, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.16, -0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <0.16, -0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00>, <0.18, -0.31, -0.00>, <-0.92, 0.38, 0.00>, <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <0.18, -0.31, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00>, <0.23, -0.23, -0.00>, <-0.70, 0.70, 0.00>, <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <0.23, -0.23, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00>, <0.31, -0.18, -0.00>, <-0.38, 0.92, 0.00>, <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <0.31, -0.18, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00>, <0.40, -0.16, -0.00>, <-0.00, 1.00, 0.00>, <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00>, <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00>, <0.40, -0.16, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00>, <0.49, -0.18, -0.00>, <0.38, 0.92, 0.00>, <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00>, <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00>, <0.49, -0.18, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00>, <0.57, -0.23, -0.00>, <0.70, 0.70, 0.00>, <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00>, <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00>, <0.57, -0.23, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00>, <0.62, -0.31, -0.00>, <0.92, 0.38, 0.00>, <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00>, <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00>, <0.62, -0.31, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00>, <0.64, -0.40, -0.00>, <1.00, -0.00, 0.00>, <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00>, <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00>, <0.64, -0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00>, <0.62, -0.49, -0.00>, <0.92, -0.38, 0.00>, <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00>, <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00>, <0.62, -0.49, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00>, <0.57, -0.57, -0.00>, <0.70, -0.70, 0.00>, <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00>, <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00>, <0.57, -0.57, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00>, <0.49, -0.62, -0.00>, <0.38, -0.92, 0.00>, <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, -0.64, -0.00>, <-0.00, -1.00, 0.00>, <0.40, -0.64, 0.16>, <-0.00, -1.00, 0.00>, <0.49, -0.62, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.16, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.16, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.64, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, -0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, -0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, -0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, -0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.40, -0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00>, <0.31, 0.18, -0.00>, <-0.38, -0.92, 0.00>, <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <0.31, 0.18, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00>, <0.23, 0.23, -0.00>, <-0.70, -0.70, 0.00>, <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <0.23, 0.23, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00>, <0.18, 0.31, -0.00>, <-0.92, -0.38, 0.00>, <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.18, 0.31, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00>, <0.16, 0.40, -0.00>, <-1.00, -0.00, 0.00>, <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <0.16, 0.40, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00>, <0.18, 0.49, -0.00>, <-0.92, 0.38, 0.00>, <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <0.18, 0.49, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00>, <0.23, 0.57, -0.00>, <-0.70, 0.70, 0.00>, <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <0.23, 0.57, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00>, <0.31, 0.62, -0.00>, <-0.38, 0.92, 0.00>, <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <0.31, 0.62, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00>, <0.40, 0.64, -0.00>, <-0.00, 1.00, 0.00>, <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00>, <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00>, <0.40, 0.64, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00>, <0.49, 0.62, -0.00>, <0.38, 0.92, 0.00>, <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00>, <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00>, <0.49, 0.62, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00>, <0.57, 0.57, -0.00>, <0.70, 0.70, 0.00>, <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00>, <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00>, <0.57, 0.57, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00>, <0.62, 0.49, -0.00>, <0.92, 0.38, 0.00>, <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00>, <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00>, <0.62, 0.49, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00>, <0.64, 0.40, -0.00>, <1.00, -0.00, 0.00>, <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00>, <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00>, <0.64, 0.40, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00>, <0.62, 0.31, -0.00>, <0.92, -0.38, 0.00>, <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00>, <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00>, <0.62, 0.31, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00>, <0.57, 0.23, -0.00>, <0.70, -0.70, 0.00>, <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00>, <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00>, <0.57, 0.23, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00>, <0.49, 0.18, -0.00>, <0.38, -0.92, 0.00>, <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, 0.16, -0.00>, <-0.00, -1.00, 0.00>, <0.40, 0.16, 0.16>, <-0.00, -1.00, 0.00>, <0.49, 0.18, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.64, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.62, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.57, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.49, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 0.31, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 0.23, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.40, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.18, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.16, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <0.31, 0.98, -0.00>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.31, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <0.31, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.31, 0.98, 0.16>, <-0.38, -0.92, 0.00>, <0.31, 0.98, -0.00>, <-0.38, -0.92, 0.00>, <0.23, 1.03, -0.00>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.23, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <0.23, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <0.31, 0.98, 0.16>, <-0.38, -0.92, 0.00> }
  smooth_triangle { <0.23, 1.03, 0.16>, <-0.70, -0.70, 0.00>, <0.23, 1.03, -0.00>, <-0.70, -0.70, 0.00>, <0.18, 1.11, -0.00>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.18, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <0.18, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <0.23, 1.03, 0.16>, <-0.70, -0.70, 0.00> }
  smooth_triangle { <0.18, 1.11, 0.16>, <-0.92, -0.38, 0.00>, <0.18, 1.11, -0.00>, <-0.92, -0.38, 0.00>, <0.16, 1.20, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.16, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.16, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.18, 1.11, 0.16>, <-0.92, -0.38, 0.00> }
  smooth_triangle { <0.16, 1.20, 0.16>, <-1.00, -0.00, 0.00>, <0.16, 1.20, -0.00>, <-1.00, -0.00, 0.00>, <0.18, 1.29, -0.00>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.18, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <0.18, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <0.16, 1.20, 0.16>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <0.18, 1.29, 0.16>, <-0.92, 0.38, 0.00>, <0.18, 1.29, -0.00>, <-0.92, 0.38, 0.00>, <0.23, 1.37, -0.00>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.23, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <0.23, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <0.18, 1.29, 0.16>, <-0.92, 0.38, 0.00> }
  smooth_triangle { <0.23, 1.37, 0.16>, <-0.70, 0.70, 0.00>, <0.23, 1.37, -0.00>, <-0.70, 0.70, 0.00>, <0.31, 1.42, -0.00>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.31, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <0.31, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <0.23, 1.37, 0.16>, <-0.70, 0.70, 0.00> }
  smooth_triangle { <0.31, 1.42, 0.16>, <-0.38, 0.92, 0.00>, <0.31, 1.42, -0.00>, <-0.38, 0.92, 0.00>, <0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <0.31, 1.42, 0.16>, <-0.38, 0.92, 0.00> }
  smooth_triangle { <0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00>, <0.40, 1.44, -0.00>, <-0.00, 1.00, 0.00>, <0.49, 1.42, -0.00>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.49, 1.42, -0.00>, <0.38, 0.92, 0.00>, <0.49, 1.42, 0.16>, <0.38, 0.92, 0.00>, <0.40, 1.44, 0.16>, <-0.00, 1.00, 0.00> }
  smooth_triangle { <0.49, 1.42, 0.16>, <0.38, 0.92, 0.00>, <0.49, 1.42, -0.00>, <0.38, 0.92, 0.00>, <0.57, 1.37, -0.00>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.57, 1.37, -0.00>, <0.70, 0.70, 0.00>, <0.57, 1.37, 0.16>, <0.70, 0.70, 0.00>, <0.49, 1.42, 0.16>, <0.38, 0.92, 0.00> }
  smooth_triangle { <0.57, 1.37, 0.16>, <0.70, 0.70, 0.00>, <0.57, 1.37, -0.00>, <0.70, 0.70, 0.00>, <0.62, 1.29, -0.00>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.62, 1.29, -0.00>, <0.92, 0.38, 0.00>, <0.62, 1.29, 0.16>, <0.92, 0.38, 0.00>, <0.57, 1.37, 0.16>, <0.70, 0.70, 0.00> }
  smooth_triangle { <0.62, 1.29, 0.16>, <0.92, 0.38, 0.00>, <0.62, 1.29, -0.00>, <0.92, 0.38, 0.00>, <0.64, 1.20, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.64, 1.20, -0.00>, <1.00, -0.00, 0.00>, <0.64, 1.20, 0.16>, <1.00, -0.00, 0.00>, <0.62, 1.29, 0.16>, <0.92, 0.38, 0.00> }
  smooth_triangle { <0.64, 1.20, 0.16>, <1.00, -0.00, 0.00>, <0.64, 1.20, -0.00>, <1.00, -0.00, 0.00>, <0.62, 1.11, -0.00>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.62, 1.11, -0.00>, <0.92, -0.38, 0.00>, <0.62, 1.11, 0.16>, <0.92, -0.38, 0.00>, <0.64, 1.20, 0.16>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.62, 1.11, 0.16>, <0.92, -0.38, 0.00>, <0.62, 1.11, -0.00>, <0.92, -0.38, 0.00>, <0.57, 1.03, -0.00>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.57, 1.03, -0.00>, <0.70, -0.70, 0.00>, <0.57, 1.03, 0.16>, <0.70, -0.70, 0.00>, <0.62, 1.11, 0.16>, <0.92, -0.38, 0.00> }
  smooth_triangle { <0.57, 1.03, 0.16>, <0.70, -0.70, 0.00>, <0.57, 1.03, -0.00>, <0.70, -0.70, 0.00>, <0.49, 0.98, -0.00>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.49, 0.98, -0.00>, <0.38, -0.92, 0.00>, <0.49, 0.98, 0.16>, <0.38, -0.92, 0.00>, <0.57, 1.03, 0.16>, <0.70, -0.70, 0.00> }
  smooth_triangle { <0.49, 0.98, 0.16>, <0.38, -0.92, 0.00>, <0.49, 0.98, -0.00>, <0.38, -0.92, 0.00>, <0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00> }
  smooth_triangle { <0.40, 0.96, -0.00>, <-0.00, -1.00, 0.00>, <0.40, 0.96, 0.16>, <-0.00, -1.00, 0.00>, <0.49, 0.98, 0.16>, <0.38, -0.92, 0.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.16, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.18, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.23, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.31, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 1.44, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 1.42, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.37, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.29, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.64, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.62, 1.11, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.57, 1.03, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.40, 1.20, 0.16>, <-0.00, -0.00, 1.00>, <0.49, 0.98, 0.16>, <-0.00, -0.00, 1.00>, <0.40, 0.96, 0.16>, <-0.00, -0.00, 1.00> }
  smooth_triangle { <0.80, -1.60, -0.96>, <1.00, -0.00, 0.00>, <0.80, -1.60, -0.00>, <1.00, -0.00, 0.00>, <0.80, 1.60, -0.00>, <1.00, -0.00, 0.00> }
  smooth_triangle { <0.80, 1.60, -0.00>, <1.00, -0.00, 0.00>, <0.80, 1.60, -0.96>, <1.00, -0.00, 0.00>, <0.80, -1.60, -0.96>, <1.00, -0.00, 0.00> }
  smooth_triangle { <-0.80, 1.60, -0.96>, <-1.00, -0.00, 0.00>, <-0.80, 1.60, -0.00>, <-1.00, -0.00, 0.00>, <-0.80, -1.60, -0.00>, <-1.00, -0.00, 0.00> }
  smooth_triangle { <-0.80, -1.60, -0.00>, <-1.00, -0.00, 0.00>, <-0.80, -1.60, -0.96>, <-1.00, -0.00, 0.00>, <-0.80, 1.60, -0.96>, <-1.00, -0.00, 0.00> }
}

#declare lc_3001_dat_clear = lc_3001_dat

camera {
  perspective
  right x * image_width / image_height
  sky<-0.127623,0.169493,0.977233>
  location <-21.3759, 24.8685, -5.76397>
  look_at <-4.5933, 2.58001, 0.293531>
  angle 30 * image_width / image_height
}

background { color rgb <1, 1, 1> }

light_source{ <3.945581, -12.046557, -9.806351>
  color rgb 0.75
  area_light 200, 200, 10, 10
  jitter
}

light_source{ <14.186247, -8.633001, 6.346772>
  color rgb 0.75
  area_light 200, 200, 10, 10
  jitter
}

light_source{ <3.945581, -15.460113, 0.434316>
  color rgb 0.5
  area_light 200, 200, 10, 10
  jitter
}

light_source{ <17.599802, -1.805891, -13.219906>
  color rgb 0.5
  area_light 200, 200, 10, 10
  jitter
}

object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, -3.0057>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, -2.0457>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, -1.0857>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, -0.1257>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, 0.8343>
}
object {
 lc_2456_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 2.5172, -3.2343, 1.7943>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, 2.7543>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 1.3858, -4.3657, 3.7143>
}
object {
 lc_2456_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 2.5172, -3.2343, 4.6743>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 4.2142, -1.5373, 2.7543>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 4.2142, -1.5373, 3.7143>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 3.6485, -2.1029, -3.0057>
}
object {
 lc_3003_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 6.4770, 0.7255, -1.0857>
}
object {
 lc_3001_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 3.9598, -1.7917, -1.0857>
}
object {
 lc_3001_dat
 texture { lc_Red }
 matrix <-0.7071, 0.7071, -0.0000, -0.7071, -0.7071, -0.0000, 0.0000, 0.0000, 1.0000, 5.9397, 0.1882, -3.0057>
}
