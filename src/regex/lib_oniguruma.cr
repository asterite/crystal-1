@[Link("oniguruma")]
lib LibOniguruma
  alias Int = LibC::Int
  alias OnigUChar = UInt8
  alias OnigOptionType = LibC::Int
  type OnigRegex = Void*
  type OnigCaptureTreeNode = Void*

  struct OnigEncodingType
    void : UInt8[160]
  end

  struct OnigSyntaxType
    void : UInt8[40]
  end

  alias OnigEncoding = OnigEncodingType*

  struct OnigErrorInfo
    enc : OnigEncoding
    par : OnigUChar*
    par_end : OnigUChar*
  end

  struct OnigRegion
    allocated : Int
    num_regs : Int
    beg : Int*
    end_ : Int*
    history_root : OnigCaptureTreeNode*
  end

  fun onig_version : UInt8*
  fun onig_initialize(encodings : OnigEncoding*, number_of_encodings : Int) : Int
  fun onig_new(regex : OnigRegex*, pattern : OnigUChar*, pattern_end : OnigUChar*,
               option : OnigOptionType, enc : OnigEncoding, syntax : OnigSyntaxType*,
               einfo : OnigErrorInfo*) : Int
  fun onig_search(regex : OnigRegex, str : OnigUChar*, end : OnigUChar*, start : OnigUChar*,
                  range : OnigUChar*, region : OnigRegion*, option : OnigOptionType) : Int
  fun onig_match(regex : OnigRegex, str : OnigUChar*, end : OnigUChar*, at : OnigUChar*,
                 region : OnigRegion*, option : OnigOptionType) : Int
  fun onig_region_new : OnigRegion*
  fun onig_number_of_captures(regex : OnigRegex) : Int
  fun onig_get_capture_tree(region : OnigRegion*) : OnigCaptureTreeNode*
  fun onig_name_to_group_numbers(regex : OnigRegex, name : OnigUChar*, name_end : OnigUChar*, nums : Int**) : Int
  fun onig_region_free(region : OnigRegion*, free_self : Int)
  fun onig_free(regex : OnigRegex)
  fun onig_end : Int

  $onig_encoding_utf8 = OnigEncodingUTF8 : OnigEncodingType
  $onig_syntax_oniguruma = OnigSyntaxOniguruma : OnigSyntaxType

  ONIG_NORMAL   =  0
  ONIG_MISMATCH = -1

  ONIG_OPTION_NONE               =   0
  ONIG_OPTION_IGNORECASE         =   1
  ONIG_OPTION_EXTEND             =   2
  ONIG_OPTION_MULTILINE          =   4
  ONIG_OPTION_SINGLELINE         =   8
  ONIG_OPTION_FIND_LONGEST       =  16
  ONIG_OPTION_NOT_EMPTY          =  32
  ONIG_OPTION_NEGATE_SINGLELINE  =  64
  ONIG_OPTION_DONT_CAPTURE_GROUP = 128
  ONIG_OPTION_CAPTURE_GROUP      = 256
end

encodings = uninitialized LibOniguruma::OnigEncoding[1]
encodings[0] = pointerof(LibOniguruma.onig_encoding_utf8)
LibOniguruma.onig_initialize(encodings, 1)
