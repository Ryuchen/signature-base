/*
   Yara Rule Set
   Author: Florian Roth
   Date: 2017-01-08
   Identifier: ShadowBroker Screenshot Rules
*/

/* Rule Set ----------------------------------------------------------------- */

rule FVEY_ShadowBrokers_Jan17_Screen_Strings {
   meta:
      description = "Detects strings derived from the ShadowBroker's leak of Windows tools/exploits"
      license = "Detection Rule License 1.1 https://github.com/Neo23x0/signature-base/blob/master/LICENSE"
      author = "Florian Roth (Nextron Systems)"
      reference = "https://bit.no.com:43110/theshadowbrokers.bit/post/message7/"
      date = "2017-01-08"
      uuid = "59832d0a-0cb2-5eb9-a4e2-36aaa09a3998"
   strings:
      $x1 = "Danderspritz" ascii wide fullword
      $x2 = "DanderSpritz" ascii wide fullword
      $x3 = "PeddleCheap" ascii wide fullword
      $x4 = "ChimneyPool Addres" ascii wide fullword

      $a1 = "Getting remote time" fullword ascii
      $a2 = "RETRIEVED" fullword ascii

      $b1 = "Added Ops library to Python search path" fullword ascii
      $b2 = "target: z0.0.0.1" fullword ascii

      $c1 = "Psp_Avoidance" fullword ascii
      $c2 = "PasswordDump" fullword ascii
      $c4 = "EventLogEdit" fullword ascii

      $d1 = "Mcl_NtElevation" fullword ascii wide
      $d2 = "Mcl_NtNativeApi" fullword ascii wide
      $d3 = "Mcl_ThreatInject" fullword ascii wide
      $d4 = "Mcl_NtMemory" fullword ascii wide
   condition:
      filesize < 2000KB and (
        1 of ($x*) or
        all of ($a*) or
        1 of ($b*) or
        ( uint16(0) == 0x5a4d and 1 of ($c*) ) or
        3 of ($c*) or
        ( uint16(0) == 0x5a4d and 3 of ($d*) )
      )
}
