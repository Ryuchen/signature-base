rule CobaltStrike_C2_Host_Indicator {
	meta:
		description = "Detects CobaltStrike C2 host artifacts"
		author = "yara@s3c.za.net"
		date = "2019-08-16"
		uuid = "7f15ee30-664e-59b8-9e31-35d88e58a45e"
	strings:
		$c2_indicator_fp = "#Host: %s"
		$c2_indicator = "#Host:"
	condition:
		$c2_indicator and not $c2_indicator_fp
		and not uint32(0) == 0x0a786564
		and not uint32(0) == 0x0a796564
}

rule CobaltStrike_Sleep_Decoder_Indicator {
	meta:
		description = "Detects CobaltStrike sleep_mask decoder"
		author = "yara@s3c.za.net"
		date = "2021-07-19"
		uuid = "d5b53d68-55f9-5837-9b0c-e7be2f3bd072"
	strings:
		$sleep_decoder = { 48 89 5C 24 08 48 89 6C 24 10 48 89 74 24 18 57 48 83 EC 20 4C 8B 51 08 41 8B F0 48 8B EA 48 8B D9 45 8B 0A 45 8B 5A 04 4D 8D 52 08 45 85 C9 }
	condition:
		$sleep_decoder
}

rule CobaltStrike_C2_Encoded_XOR_Config_Indicator {
	meta:
		description = "Detects CobaltStrike C2 encoded profile configuration"
		author = "yara@s3c.za.net"
		date = "2021-07-08"
		uuid = "8e33c63d-eaba-5851-88f4-ef7261a0a618"
    strings:
		$s000 = { 00 01 00 01 00 02 ?? ?? 00 02 00 01 00 02 ?? ?? 00 03 00 02 00 04 ?? ?? ?? ?? 00 04 00 02 00 04 ?? ?? ?? ?? 00 05 00 01 00 02 ?? ?? }
		$s001 = { 01 00 01 00 01 03 ?? ?? 01 03 01 00 01 03 ?? ?? 01 02 01 03 01 05 ?? ?? ?? ?? 01 05 01 03 01 05 ?? ?? ?? ?? 01 04 01 00 01 03 ?? ?? }
		$s002 = { 02 03 02 03 02 00 ?? ?? 02 00 02 03 02 00 ?? ?? 02 01 02 00 02 06 ?? ?? ?? ?? 02 06 02 00 02 06 ?? ?? ?? ?? 02 07 02 03 02 00 ?? ?? }
		$s003 = { 03 02 03 02 03 01 ?? ?? 03 01 03 02 03 01 ?? ?? 03 00 03 01 03 07 ?? ?? ?? ?? 03 07 03 01 03 07 ?? ?? ?? ?? 03 06 03 02 03 01 ?? ?? }
		$s004 = { 04 05 04 05 04 06 ?? ?? 04 06 04 05 04 06 ?? ?? 04 07 04 06 04 00 ?? ?? ?? ?? 04 00 04 06 04 00 ?? ?? ?? ?? 04 01 04 05 04 06 ?? ?? }
		$s005 = { 05 04 05 04 05 07 ?? ?? 05 07 05 04 05 07 ?? ?? 05 06 05 07 05 01 ?? ?? ?? ?? 05 01 05 07 05 01 ?? ?? ?? ?? 05 00 05 04 05 07 ?? ?? }
		$s006 = { 06 07 06 07 06 04 ?? ?? 06 04 06 07 06 04 ?? ?? 06 05 06 04 06 02 ?? ?? ?? ?? 06 02 06 04 06 02 ?? ?? ?? ?? 06 03 06 07 06 04 ?? ?? }
		$s007 = { 07 06 07 06 07 05 ?? ?? 07 05 07 06 07 05 ?? ?? 07 04 07 05 07 03 ?? ?? ?? ?? 07 03 07 05 07 03 ?? ?? ?? ?? 07 02 07 06 07 05 ?? ?? }
		$s008 = { 08 09 08 09 08 0A ?? ?? 08 0A 08 09 08 0A ?? ?? 08 0B 08 0A 08 0C ?? ?? ?? ?? 08 0C 08 0A 08 0C ?? ?? ?? ?? 08 0D 08 09 08 0A ?? ?? }
		$s009 = { 09 08 09 08 09 0B ?? ?? 09 0B 09 08 09 0B ?? ?? 09 0A 09 0B 09 0D ?? ?? ?? ?? 09 0D 09 0B 09 0D ?? ?? ?? ?? 09 0C 09 08 09 0B ?? ?? }
		$s010 = { 0A 0B 0A 0B 0A 08 ?? ?? 0A 08 0A 0B 0A 08 ?? ?? 0A 09 0A 08 0A 0E ?? ?? ?? ?? 0A 0E 0A 08 0A 0E ?? ?? ?? ?? 0A 0F 0A 0B 0A 08 ?? ?? }
		$s011 = { 0B 0A 0B 0A 0B 09 ?? ?? 0B 09 0B 0A 0B 09 ?? ?? 0B 08 0B 09 0B 0F ?? ?? ?? ?? 0B 0F 0B 09 0B 0F ?? ?? ?? ?? 0B 0E 0B 0A 0B 09 ?? ?? }
		$s012 = { 0C 0D 0C 0D 0C 0E ?? ?? 0C 0E 0C 0D 0C 0E ?? ?? 0C 0F 0C 0E 0C 08 ?? ?? ?? ?? 0C 08 0C 0E 0C 08 ?? ?? ?? ?? 0C 09 0C 0D 0C 0E ?? ?? }
		$s013 = { 0D 0C 0D 0C 0D 0F ?? ?? 0D 0F 0D 0C 0D 0F ?? ?? 0D 0E 0D 0F 0D 09 ?? ?? ?? ?? 0D 09 0D 0F 0D 09 ?? ?? ?? ?? 0D 08 0D 0C 0D 0F ?? ?? }
		$s014 = { 0E 0F 0E 0F 0E 0C ?? ?? 0E 0C 0E 0F 0E 0C ?? ?? 0E 0D 0E 0C 0E 0A ?? ?? ?? ?? 0E 0A 0E 0C 0E 0A ?? ?? ?? ?? 0E 0B 0E 0F 0E 0C ?? ?? }
		$s015 = { 0F 0E 0F 0E 0F 0D ?? ?? 0F 0D 0F 0E 0F 0D ?? ?? 0F 0C 0F 0D 0F 0B ?? ?? ?? ?? 0F 0B 0F 0D 0F 0B ?? ?? ?? ?? 0F 0A 0F 0E 0F 0D ?? ?? }
		$s016 = { 10 11 10 11 10 12 ?? ?? 10 12 10 11 10 12 ?? ?? 10 13 10 12 10 14 ?? ?? ?? ?? 10 14 10 12 10 14 ?? ?? ?? ?? 10 15 10 11 10 12 ?? ?? }
		$s017 = { 11 10 11 10 11 13 ?? ?? 11 13 11 10 11 13 ?? ?? 11 12 11 13 11 15 ?? ?? ?? ?? 11 15 11 13 11 15 ?? ?? ?? ?? 11 14 11 10 11 13 ?? ?? }
		$s018 = { 12 13 12 13 12 10 ?? ?? 12 10 12 13 12 10 ?? ?? 12 11 12 10 12 16 ?? ?? ?? ?? 12 16 12 10 12 16 ?? ?? ?? ?? 12 17 12 13 12 10 ?? ?? }
		$s019 = { 13 12 13 12 13 11 ?? ?? 13 11 13 12 13 11 ?? ?? 13 10 13 11 13 17 ?? ?? ?? ?? 13 17 13 11 13 17 ?? ?? ?? ?? 13 16 13 12 13 11 ?? ?? }
		$s020 = { 14 15 14 15 14 16 ?? ?? 14 16 14 15 14 16 ?? ?? 14 17 14 16 14 10 ?? ?? ?? ?? 14 10 14 16 14 10 ?? ?? ?? ?? 14 11 14 15 14 16 ?? ?? }
		$s021 = { 15 14 15 14 15 17 ?? ?? 15 17 15 14 15 17 ?? ?? 15 16 15 17 15 11 ?? ?? ?? ?? 15 11 15 17 15 11 ?? ?? ?? ?? 15 10 15 14 15 17 ?? ?? }
		$s022 = { 16 17 16 17 16 14 ?? ?? 16 14 16 17 16 14 ?? ?? 16 15 16 14 16 12 ?? ?? ?? ?? 16 12 16 14 16 12 ?? ?? ?? ?? 16 13 16 17 16 14 ?? ?? }
		$s023 = { 17 16 17 16 17 15 ?? ?? 17 15 17 16 17 15 ?? ?? 17 14 17 15 17 13 ?? ?? ?? ?? 17 13 17 15 17 13 ?? ?? ?? ?? 17 12 17 16 17 15 ?? ?? }
		$s024 = { 18 19 18 19 18 1A ?? ?? 18 1A 18 19 18 1A ?? ?? 18 1B 18 1A 18 1C ?? ?? ?? ?? 18 1C 18 1A 18 1C ?? ?? ?? ?? 18 1D 18 19 18 1A ?? ?? }
		$s025 = { 19 18 19 18 19 1B ?? ?? 19 1B 19 18 19 1B ?? ?? 19 1A 19 1B 19 1D ?? ?? ?? ?? 19 1D 19 1B 19 1D ?? ?? ?? ?? 19 1C 19 18 19 1B ?? ?? }
		$s026 = { 1A 1B 1A 1B 1A 18 ?? ?? 1A 18 1A 1B 1A 18 ?? ?? 1A 19 1A 18 1A 1E ?? ?? ?? ?? 1A 1E 1A 18 1A 1E ?? ?? ?? ?? 1A 1F 1A 1B 1A 18 ?? ?? }
		$s027 = { 1B 1A 1B 1A 1B 19 ?? ?? 1B 19 1B 1A 1B 19 ?? ?? 1B 18 1B 19 1B 1F ?? ?? ?? ?? 1B 1F 1B 19 1B 1F ?? ?? ?? ?? 1B 1E 1B 1A 1B 19 ?? ?? }
		$s028 = { 1C 1D 1C 1D 1C 1E ?? ?? 1C 1E 1C 1D 1C 1E ?? ?? 1C 1F 1C 1E 1C 18 ?? ?? ?? ?? 1C 18 1C 1E 1C 18 ?? ?? ?? ?? 1C 19 1C 1D 1C 1E ?? ?? }
		$s029 = { 1D 1C 1D 1C 1D 1F ?? ?? 1D 1F 1D 1C 1D 1F ?? ?? 1D 1E 1D 1F 1D 19 ?? ?? ?? ?? 1D 19 1D 1F 1D 19 ?? ?? ?? ?? 1D 18 1D 1C 1D 1F ?? ?? }
		$s030 = { 1E 1F 1E 1F 1E 1C ?? ?? 1E 1C 1E 1F 1E 1C ?? ?? 1E 1D 1E 1C 1E 1A ?? ?? ?? ?? 1E 1A 1E 1C 1E 1A ?? ?? ?? ?? 1E 1B 1E 1F 1E 1C ?? ?? }
		$s031 = { 1F 1E 1F 1E 1F 1D ?? ?? 1F 1D 1F 1E 1F 1D ?? ?? 1F 1C 1F 1D 1F 1B ?? ?? ?? ?? 1F 1B 1F 1D 1F 1B ?? ?? ?? ?? 1F 1A 1F 1E 1F 1D ?? ?? }
		$s032 = { 20 21 20 21 20 22 ?? ?? 20 22 20 21 20 22 ?? ?? 20 23 20 22 20 24 ?? ?? ?? ?? 20 24 20 22 20 24 ?? ?? ?? ?? 20 25 20 21 20 22 ?? ?? }
		$s033 = { 21 20 21 20 21 23 ?? ?? 21 23 21 20 21 23 ?? ?? 21 22 21 23 21 25 ?? ?? ?? ?? 21 25 21 23 21 25 ?? ?? ?? ?? 21 24 21 20 21 23 ?? ?? }
		$s034 = { 22 23 22 23 22 20 ?? ?? 22 20 22 23 22 20 ?? ?? 22 21 22 20 22 26 ?? ?? ?? ?? 22 26 22 20 22 26 ?? ?? ?? ?? 22 27 22 23 22 20 ?? ?? }
		$s035 = { 23 22 23 22 23 21 ?? ?? 23 21 23 22 23 21 ?? ?? 23 20 23 21 23 27 ?? ?? ?? ?? 23 27 23 21 23 27 ?? ?? ?? ?? 23 26 23 22 23 21 ?? ?? }
		$s036 = { 24 25 24 25 24 26 ?? ?? 24 26 24 25 24 26 ?? ?? 24 27 24 26 24 20 ?? ?? ?? ?? 24 20 24 26 24 20 ?? ?? ?? ?? 24 21 24 25 24 26 ?? ?? }
		$s037 = { 25 24 25 24 25 27 ?? ?? 25 27 25 24 25 27 ?? ?? 25 26 25 27 25 21 ?? ?? ?? ?? 25 21 25 27 25 21 ?? ?? ?? ?? 25 20 25 24 25 27 ?? ?? }
		$s038 = { 26 27 26 27 26 24 ?? ?? 26 24 26 27 26 24 ?? ?? 26 25 26 24 26 22 ?? ?? ?? ?? 26 22 26 24 26 22 ?? ?? ?? ?? 26 23 26 27 26 24 ?? ?? }
		$s039 = { 27 26 27 26 27 25 ?? ?? 27 25 27 26 27 25 ?? ?? 27 24 27 25 27 23 ?? ?? ?? ?? 27 23 27 25 27 23 ?? ?? ?? ?? 27 22 27 26 27 25 ?? ?? }
		$s040 = { 28 29 28 29 28 2A ?? ?? 28 2A 28 29 28 2A ?? ?? 28 2B 28 2A 28 2C ?? ?? ?? ?? 28 2C 28 2A 28 2C ?? ?? ?? ?? 28 2D 28 29 28 2A ?? ?? }
		$s041 = { 29 28 29 28 29 2B ?? ?? 29 2B 29 28 29 2B ?? ?? 29 2A 29 2B 29 2D ?? ?? ?? ?? 29 2D 29 2B 29 2D ?? ?? ?? ?? 29 2C 29 28 29 2B ?? ?? }
		$s042 = { 2A 2B 2A 2B 2A 28 ?? ?? 2A 28 2A 2B 2A 28 ?? ?? 2A 29 2A 28 2A 2E ?? ?? ?? ?? 2A 2E 2A 28 2A 2E ?? ?? ?? ?? 2A 2F 2A 2B 2A 28 ?? ?? }
		$s043 = { 2B 2A 2B 2A 2B 29 ?? ?? 2B 29 2B 2A 2B 29 ?? ?? 2B 28 2B 29 2B 2F ?? ?? ?? ?? 2B 2F 2B 29 2B 2F ?? ?? ?? ?? 2B 2E 2B 2A 2B 29 ?? ?? }
		$s044 = { 2C 2D 2C 2D 2C 2E ?? ?? 2C 2E 2C 2D 2C 2E ?? ?? 2C 2F 2C 2E 2C 28 ?? ?? ?? ?? 2C 28 2C 2E 2C 28 ?? ?? ?? ?? 2C 29 2C 2D 2C 2E ?? ?? }
		$s045 = { 2D 2C 2D 2C 2D 2F ?? ?? 2D 2F 2D 2C 2D 2F ?? ?? 2D 2E 2D 2F 2D 29 ?? ?? ?? ?? 2D 29 2D 2F 2D 29 ?? ?? ?? ?? 2D 28 2D 2C 2D 2F ?? ?? }
		$s046 = { 2E 2F 2E 2F 2E 2C ?? ?? 2E 2C 2E 2F 2E 2C ?? ?? 2E 2D 2E 2C 2E 2A ?? ?? ?? ?? 2E 2A 2E 2C 2E 2A ?? ?? ?? ?? 2E 2B 2E 2F 2E 2C ?? ?? }
		$s047 = { 2F 2E 2F 2E 2F 2D ?? ?? 2F 2D 2F 2E 2F 2D ?? ?? 2F 2C 2F 2D 2F 2B ?? ?? ?? ?? 2F 2B 2F 2D 2F 2B ?? ?? ?? ?? 2F 2A 2F 2E 2F 2D ?? ?? }
		$s048 = { 30 31 30 31 30 32 ?? ?? 30 32 30 31 30 32 ?? ?? 30 33 30 32 30 34 ?? ?? ?? ?? 30 34 30 32 30 34 ?? ?? ?? ?? 30 35 30 31 30 32 ?? ?? }
		$s049 = { 31 30 31 30 31 33 ?? ?? 31 33 31 30 31 33 ?? ?? 31 32 31 33 31 35 ?? ?? ?? ?? 31 35 31 33 31 35 ?? ?? ?? ?? 31 34 31 30 31 33 ?? ?? }
		$s050 = { 32 33 32 33 32 30 ?? ?? 32 30 32 33 32 30 ?? ?? 32 31 32 30 32 36 ?? ?? ?? ?? 32 36 32 30 32 36 ?? ?? ?? ?? 32 37 32 33 32 30 ?? ?? }
		$s051 = { 33 32 33 32 33 31 ?? ?? 33 31 33 32 33 31 ?? ?? 33 30 33 31 33 37 ?? ?? ?? ?? 33 37 33 31 33 37 ?? ?? ?? ?? 33 36 33 32 33 31 ?? ?? }
		$s052 = { 34 35 34 35 34 36 ?? ?? 34 36 34 35 34 36 ?? ?? 34 37 34 36 34 30 ?? ?? ?? ?? 34 30 34 36 34 30 ?? ?? ?? ?? 34 31 34 35 34 36 ?? ?? }
		$s053 = { 35 34 35 34 35 37 ?? ?? 35 37 35 34 35 37 ?? ?? 35 36 35 37 35 31 ?? ?? ?? ?? 35 31 35 37 35 31 ?? ?? ?? ?? 35 30 35 34 35 37 ?? ?? }
		$s054 = { 36 37 36 37 36 34 ?? ?? 36 34 36 37 36 34 ?? ?? 36 35 36 34 36 32 ?? ?? ?? ?? 36 32 36 34 36 32 ?? ?? ?? ?? 36 33 36 37 36 34 ?? ?? }
		$s055 = { 37 36 37 36 37 35 ?? ?? 37 35 37 36 37 35 ?? ?? 37 34 37 35 37 33 ?? ?? ?? ?? 37 33 37 35 37 33 ?? ?? ?? ?? 37 32 37 36 37 35 ?? ?? }
		$s056 = { 38 39 38 39 38 3A ?? ?? 38 3A 38 39 38 3A ?? ?? 38 3B 38 3A 38 3C ?? ?? ?? ?? 38 3C 38 3A 38 3C ?? ?? ?? ?? 38 3D 38 39 38 3A ?? ?? }
		$s057 = { 39 38 39 38 39 3B ?? ?? 39 3B 39 38 39 3B ?? ?? 39 3A 39 3B 39 3D ?? ?? ?? ?? 39 3D 39 3B 39 3D ?? ?? ?? ?? 39 3C 39 38 39 3B ?? ?? }
		$s058 = { 3A 3B 3A 3B 3A 38 ?? ?? 3A 38 3A 3B 3A 38 ?? ?? 3A 39 3A 38 3A 3E ?? ?? ?? ?? 3A 3E 3A 38 3A 3E ?? ?? ?? ?? 3A 3F 3A 3B 3A 38 ?? ?? }
		$s059 = { 3B 3A 3B 3A 3B 39 ?? ?? 3B 39 3B 3A 3B 39 ?? ?? 3B 38 3B 39 3B 3F ?? ?? ?? ?? 3B 3F 3B 39 3B 3F ?? ?? ?? ?? 3B 3E 3B 3A 3B 39 ?? ?? }
		$s060 = { 3C 3D 3C 3D 3C 3E ?? ?? 3C 3E 3C 3D 3C 3E ?? ?? 3C 3F 3C 3E 3C 38 ?? ?? ?? ?? 3C 38 3C 3E 3C 38 ?? ?? ?? ?? 3C 39 3C 3D 3C 3E ?? ?? }
		$s061 = { 3D 3C 3D 3C 3D 3F ?? ?? 3D 3F 3D 3C 3D 3F ?? ?? 3D 3E 3D 3F 3D 39 ?? ?? ?? ?? 3D 39 3D 3F 3D 39 ?? ?? ?? ?? 3D 38 3D 3C 3D 3F ?? ?? }
		$s062 = { 3E 3F 3E 3F 3E 3C ?? ?? 3E 3C 3E 3F 3E 3C ?? ?? 3E 3D 3E 3C 3E 3A ?? ?? ?? ?? 3E 3A 3E 3C 3E 3A ?? ?? ?? ?? 3E 3B 3E 3F 3E 3C ?? ?? }
		$s063 = { 3F 3E 3F 3E 3F 3D ?? ?? 3F 3D 3F 3E 3F 3D ?? ?? 3F 3C 3F 3D 3F 3B ?? ?? ?? ?? 3F 3B 3F 3D 3F 3B ?? ?? ?? ?? 3F 3A 3F 3E 3F 3D ?? ?? }
		$s064 = { 40 41 40 41 40 42 ?? ?? 40 42 40 41 40 42 ?? ?? 40 43 40 42 40 44 ?? ?? ?? ?? 40 44 40 42 40 44 ?? ?? ?? ?? 40 45 40 41 40 42 ?? ?? }
		$s065 = { 41 40 41 40 41 43 ?? ?? 41 43 41 40 41 43 ?? ?? 41 42 41 43 41 45 ?? ?? ?? ?? 41 45 41 43 41 45 ?? ?? ?? ?? 41 44 41 40 41 43 ?? ?? }
		$s066 = { 42 43 42 43 42 40 ?? ?? 42 40 42 43 42 40 ?? ?? 42 41 42 40 42 46 ?? ?? ?? ?? 42 46 42 40 42 46 ?? ?? ?? ?? 42 47 42 43 42 40 ?? ?? }
		$s067 = { 43 42 43 42 43 41 ?? ?? 43 41 43 42 43 41 ?? ?? 43 40 43 41 43 47 ?? ?? ?? ?? 43 47 43 41 43 47 ?? ?? ?? ?? 43 46 43 42 43 41 ?? ?? }
		$s068 = { 44 45 44 45 44 46 ?? ?? 44 46 44 45 44 46 ?? ?? 44 47 44 46 44 40 ?? ?? ?? ?? 44 40 44 46 44 40 ?? ?? ?? ?? 44 41 44 45 44 46 ?? ?? }
		$s069 = { 45 44 45 44 45 47 ?? ?? 45 47 45 44 45 47 ?? ?? 45 46 45 47 45 41 ?? ?? ?? ?? 45 41 45 47 45 41 ?? ?? ?? ?? 45 40 45 44 45 47 ?? ?? }
		$s070 = { 46 47 46 47 46 44 ?? ?? 46 44 46 47 46 44 ?? ?? 46 45 46 44 46 42 ?? ?? ?? ?? 46 42 46 44 46 42 ?? ?? ?? ?? 46 43 46 47 46 44 ?? ?? }
		$s071 = { 47 46 47 46 47 45 ?? ?? 47 45 47 46 47 45 ?? ?? 47 44 47 45 47 43 ?? ?? ?? ?? 47 43 47 45 47 43 ?? ?? ?? ?? 47 42 47 46 47 45 ?? ?? }
		$s072 = { 48 49 48 49 48 4A ?? ?? 48 4A 48 49 48 4A ?? ?? 48 4B 48 4A 48 4C ?? ?? ?? ?? 48 4C 48 4A 48 4C ?? ?? ?? ?? 48 4D 48 49 48 4A ?? ?? }
		$s073 = { 49 48 49 48 49 4B ?? ?? 49 4B 49 48 49 4B ?? ?? 49 4A 49 4B 49 4D ?? ?? ?? ?? 49 4D 49 4B 49 4D ?? ?? ?? ?? 49 4C 49 48 49 4B ?? ?? }
		$s074 = { 4A 4B 4A 4B 4A 48 ?? ?? 4A 48 4A 4B 4A 48 ?? ?? 4A 49 4A 48 4A 4E ?? ?? ?? ?? 4A 4E 4A 48 4A 4E ?? ?? ?? ?? 4A 4F 4A 4B 4A 48 ?? ?? }
		$s075 = { 4B 4A 4B 4A 4B 49 ?? ?? 4B 49 4B 4A 4B 49 ?? ?? 4B 48 4B 49 4B 4F ?? ?? ?? ?? 4B 4F 4B 49 4B 4F ?? ?? ?? ?? 4B 4E 4B 4A 4B 49 ?? ?? }
		$s076 = { 4C 4D 4C 4D 4C 4E ?? ?? 4C 4E 4C 4D 4C 4E ?? ?? 4C 4F 4C 4E 4C 48 ?? ?? ?? ?? 4C 48 4C 4E 4C 48 ?? ?? ?? ?? 4C 49 4C 4D 4C 4E ?? ?? }
		$s077 = { 4D 4C 4D 4C 4D 4F ?? ?? 4D 4F 4D 4C 4D 4F ?? ?? 4D 4E 4D 4F 4D 49 ?? ?? ?? ?? 4D 49 4D 4F 4D 49 ?? ?? ?? ?? 4D 48 4D 4C 4D 4F ?? ?? }
		$s078 = { 4E 4F 4E 4F 4E 4C ?? ?? 4E 4C 4E 4F 4E 4C ?? ?? 4E 4D 4E 4C 4E 4A ?? ?? ?? ?? 4E 4A 4E 4C 4E 4A ?? ?? ?? ?? 4E 4B 4E 4F 4E 4C ?? ?? }
		$s079 = { 4F 4E 4F 4E 4F 4D ?? ?? 4F 4D 4F 4E 4F 4D ?? ?? 4F 4C 4F 4D 4F 4B ?? ?? ?? ?? 4F 4B 4F 4D 4F 4B ?? ?? ?? ?? 4F 4A 4F 4E 4F 4D ?? ?? }
		$s080 = { 50 51 50 51 50 52 ?? ?? 50 52 50 51 50 52 ?? ?? 50 53 50 52 50 54 ?? ?? ?? ?? 50 54 50 52 50 54 ?? ?? ?? ?? 50 55 50 51 50 52 ?? ?? }
		$s081 = { 51 50 51 50 51 53 ?? ?? 51 53 51 50 51 53 ?? ?? 51 52 51 53 51 55 ?? ?? ?? ?? 51 55 51 53 51 55 ?? ?? ?? ?? 51 54 51 50 51 53 ?? ?? }
		$s082 = { 52 53 52 53 52 50 ?? ?? 52 50 52 53 52 50 ?? ?? 52 51 52 50 52 56 ?? ?? ?? ?? 52 56 52 50 52 56 ?? ?? ?? ?? 52 57 52 53 52 50 ?? ?? }
		$s083 = { 53 52 53 52 53 51 ?? ?? 53 51 53 52 53 51 ?? ?? 53 50 53 51 53 57 ?? ?? ?? ?? 53 57 53 51 53 57 ?? ?? ?? ?? 53 56 53 52 53 51 ?? ?? }
		$s084 = { 54 55 54 55 54 56 ?? ?? 54 56 54 55 54 56 ?? ?? 54 57 54 56 54 50 ?? ?? ?? ?? 54 50 54 56 54 50 ?? ?? ?? ?? 54 51 54 55 54 56 ?? ?? }
		$s085 = { 55 54 55 54 55 57 ?? ?? 55 57 55 54 55 57 ?? ?? 55 56 55 57 55 51 ?? ?? ?? ?? 55 51 55 57 55 51 ?? ?? ?? ?? 55 50 55 54 55 57 ?? ?? }
		$s086 = { 56 57 56 57 56 54 ?? ?? 56 54 56 57 56 54 ?? ?? 56 55 56 54 56 52 ?? ?? ?? ?? 56 52 56 54 56 52 ?? ?? ?? ?? 56 53 56 57 56 54 ?? ?? }
		$s087 = { 57 56 57 56 57 55 ?? ?? 57 55 57 56 57 55 ?? ?? 57 54 57 55 57 53 ?? ?? ?? ?? 57 53 57 55 57 53 ?? ?? ?? ?? 57 52 57 56 57 55 ?? ?? }
		$s088 = { 58 59 58 59 58 5A ?? ?? 58 5A 58 59 58 5A ?? ?? 58 5B 58 5A 58 5C ?? ?? ?? ?? 58 5C 58 5A 58 5C ?? ?? ?? ?? 58 5D 58 59 58 5A ?? ?? }
		$s089 = { 59 58 59 58 59 5B ?? ?? 59 5B 59 58 59 5B ?? ?? 59 5A 59 5B 59 5D ?? ?? ?? ?? 59 5D 59 5B 59 5D ?? ?? ?? ?? 59 5C 59 58 59 5B ?? ?? }
		$s090 = { 5A 5B 5A 5B 5A 58 ?? ?? 5A 58 5A 5B 5A 58 ?? ?? 5A 59 5A 58 5A 5E ?? ?? ?? ?? 5A 5E 5A 58 5A 5E ?? ?? ?? ?? 5A 5F 5A 5B 5A 58 ?? ?? }
		$s091 = { 5B 5A 5B 5A 5B 59 ?? ?? 5B 59 5B 5A 5B 59 ?? ?? 5B 58 5B 59 5B 5F ?? ?? ?? ?? 5B 5F 5B 59 5B 5F ?? ?? ?? ?? 5B 5E 5B 5A 5B 59 ?? ?? }
		$s092 = { 5C 5D 5C 5D 5C 5E ?? ?? 5C 5E 5C 5D 5C 5E ?? ?? 5C 5F 5C 5E 5C 58 ?? ?? ?? ?? 5C 58 5C 5E 5C 58 ?? ?? ?? ?? 5C 59 5C 5D 5C 5E ?? ?? }
		$s093 = { 5D 5C 5D 5C 5D 5F ?? ?? 5D 5F 5D 5C 5D 5F ?? ?? 5D 5E 5D 5F 5D 59 ?? ?? ?? ?? 5D 59 5D 5F 5D 59 ?? ?? ?? ?? 5D 58 5D 5C 5D 5F ?? ?? }
		$s094 = { 5E 5F 5E 5F 5E 5C ?? ?? 5E 5C 5E 5F 5E 5C ?? ?? 5E 5D 5E 5C 5E 5A ?? ?? ?? ?? 5E 5A 5E 5C 5E 5A ?? ?? ?? ?? 5E 5B 5E 5F 5E 5C ?? ?? }
		$s095 = { 5F 5E 5F 5E 5F 5D ?? ?? 5F 5D 5F 5E 5F 5D ?? ?? 5F 5C 5F 5D 5F 5B ?? ?? ?? ?? 5F 5B 5F 5D 5F 5B ?? ?? ?? ?? 5F 5A 5F 5E 5F 5D ?? ?? }
		$s096 = { 60 61 60 61 60 62 ?? ?? 60 62 60 61 60 62 ?? ?? 60 63 60 62 60 64 ?? ?? ?? ?? 60 64 60 62 60 64 ?? ?? ?? ?? 60 65 60 61 60 62 ?? ?? }
		$s097 = { 61 60 61 60 61 63 ?? ?? 61 63 61 60 61 63 ?? ?? 61 62 61 63 61 65 ?? ?? ?? ?? 61 65 61 63 61 65 ?? ?? ?? ?? 61 64 61 60 61 63 ?? ?? }
		$s098 = { 62 63 62 63 62 60 ?? ?? 62 60 62 63 62 60 ?? ?? 62 61 62 60 62 66 ?? ?? ?? ?? 62 66 62 60 62 66 ?? ?? ?? ?? 62 67 62 63 62 60 ?? ?? }
		$s099 = { 63 62 63 62 63 61 ?? ?? 63 61 63 62 63 61 ?? ?? 63 60 63 61 63 67 ?? ?? ?? ?? 63 67 63 61 63 67 ?? ?? ?? ?? 63 66 63 62 63 61 ?? ?? }
		$s100 = { 64 65 64 65 64 66 ?? ?? 64 66 64 65 64 66 ?? ?? 64 67 64 66 64 60 ?? ?? ?? ?? 64 60 64 66 64 60 ?? ?? ?? ?? 64 61 64 65 64 66 ?? ?? }
		$s101 = { 65 64 65 64 65 67 ?? ?? 65 67 65 64 65 67 ?? ?? 65 66 65 67 65 61 ?? ?? ?? ?? 65 61 65 67 65 61 ?? ?? ?? ?? 65 60 65 64 65 67 ?? ?? }
		$s102 = { 66 67 66 67 66 64 ?? ?? 66 64 66 67 66 64 ?? ?? 66 65 66 64 66 62 ?? ?? ?? ?? 66 62 66 64 66 62 ?? ?? ?? ?? 66 63 66 67 66 64 ?? ?? }
		$s103 = { 67 66 67 66 67 65 ?? ?? 67 65 67 66 67 65 ?? ?? 67 64 67 65 67 63 ?? ?? ?? ?? 67 63 67 65 67 63 ?? ?? ?? ?? 67 62 67 66 67 65 ?? ?? }
		$s104 = { 68 69 68 69 68 6A ?? ?? 68 6A 68 69 68 6A ?? ?? 68 6B 68 6A 68 6C ?? ?? ?? ?? 68 6C 68 6A 68 6C ?? ?? ?? ?? 68 6D 68 69 68 6A ?? ?? }
		$s105 = { 69 68 69 68 69 6B ?? ?? 69 6B 69 68 69 6B ?? ?? 69 6A 69 6B 69 6D ?? ?? ?? ?? 69 6D 69 6B 69 6D ?? ?? ?? ?? 69 6C 69 68 69 6B ?? ?? }
		$s106 = { 6A 6B 6A 6B 6A 68 ?? ?? 6A 68 6A 6B 6A 68 ?? ?? 6A 69 6A 68 6A 6E ?? ?? ?? ?? 6A 6E 6A 68 6A 6E ?? ?? ?? ?? 6A 6F 6A 6B 6A 68 ?? ?? }
		$s107 = { 6B 6A 6B 6A 6B 69 ?? ?? 6B 69 6B 6A 6B 69 ?? ?? 6B 68 6B 69 6B 6F ?? ?? ?? ?? 6B 6F 6B 69 6B 6F ?? ?? ?? ?? 6B 6E 6B 6A 6B 69 ?? ?? }
		$s108 = { 6C 6D 6C 6D 6C 6E ?? ?? 6C 6E 6C 6D 6C 6E ?? ?? 6C 6F 6C 6E 6C 68 ?? ?? ?? ?? 6C 68 6C 6E 6C 68 ?? ?? ?? ?? 6C 69 6C 6D 6C 6E ?? ?? }
		$s109 = { 6D 6C 6D 6C 6D 6F ?? ?? 6D 6F 6D 6C 6D 6F ?? ?? 6D 6E 6D 6F 6D 69 ?? ?? ?? ?? 6D 69 6D 6F 6D 69 ?? ?? ?? ?? 6D 68 6D 6C 6D 6F ?? ?? }
		$s110 = { 6E 6F 6E 6F 6E 6C ?? ?? 6E 6C 6E 6F 6E 6C ?? ?? 6E 6D 6E 6C 6E 6A ?? ?? ?? ?? 6E 6A 6E 6C 6E 6A ?? ?? ?? ?? 6E 6B 6E 6F 6E 6C ?? ?? }
		$s111 = { 6F 6E 6F 6E 6F 6D ?? ?? 6F 6D 6F 6E 6F 6D ?? ?? 6F 6C 6F 6D 6F 6B ?? ?? ?? ?? 6F 6B 6F 6D 6F 6B ?? ?? ?? ?? 6F 6A 6F 6E 6F 6D ?? ?? }
		$s112 = { 70 71 70 71 70 72 ?? ?? 70 72 70 71 70 72 ?? ?? 70 73 70 72 70 74 ?? ?? ?? ?? 70 74 70 72 70 74 ?? ?? ?? ?? 70 75 70 71 70 72 ?? ?? }
		$s113 = { 71 70 71 70 71 73 ?? ?? 71 73 71 70 71 73 ?? ?? 71 72 71 73 71 75 ?? ?? ?? ?? 71 75 71 73 71 75 ?? ?? ?? ?? 71 74 71 70 71 73 ?? ?? }
		$s114 = { 72 73 72 73 72 70 ?? ?? 72 70 72 73 72 70 ?? ?? 72 71 72 70 72 76 ?? ?? ?? ?? 72 76 72 70 72 76 ?? ?? ?? ?? 72 77 72 73 72 70 ?? ?? }
		$s115 = { 73 72 73 72 73 71 ?? ?? 73 71 73 72 73 71 ?? ?? 73 70 73 71 73 77 ?? ?? ?? ?? 73 77 73 71 73 77 ?? ?? ?? ?? 73 76 73 72 73 71 ?? ?? }
		$s116 = { 74 75 74 75 74 76 ?? ?? 74 76 74 75 74 76 ?? ?? 74 77 74 76 74 70 ?? ?? ?? ?? 74 70 74 76 74 70 ?? ?? ?? ?? 74 71 74 75 74 76 ?? ?? }
		$s117 = { 75 74 75 74 75 77 ?? ?? 75 77 75 74 75 77 ?? ?? 75 76 75 77 75 71 ?? ?? ?? ?? 75 71 75 77 75 71 ?? ?? ?? ?? 75 70 75 74 75 77 ?? ?? }
		$s118 = { 76 77 76 77 76 74 ?? ?? 76 74 76 77 76 74 ?? ?? 76 75 76 74 76 72 ?? ?? ?? ?? 76 72 76 74 76 72 ?? ?? ?? ?? 76 73 76 77 76 74 ?? ?? }
		$s119 = { 77 76 77 76 77 75 ?? ?? 77 75 77 76 77 75 ?? ?? 77 74 77 75 77 73 ?? ?? ?? ?? 77 73 77 75 77 73 ?? ?? ?? ?? 77 72 77 76 77 75 ?? ?? }
		$s120 = { 78 79 78 79 78 7A ?? ?? 78 7A 78 79 78 7A ?? ?? 78 7B 78 7A 78 7C ?? ?? ?? ?? 78 7C 78 7A 78 7C ?? ?? ?? ?? 78 7D 78 79 78 7A ?? ?? }
		$s121 = { 79 78 79 78 79 7B ?? ?? 79 7B 79 78 79 7B ?? ?? 79 7A 79 7B 79 7D ?? ?? ?? ?? 79 7D 79 7B 79 7D ?? ?? ?? ?? 79 7C 79 78 79 7B ?? ?? }
		$s122 = { 7A 7B 7A 7B 7A 78 ?? ?? 7A 78 7A 7B 7A 78 ?? ?? 7A 79 7A 78 7A 7E ?? ?? ?? ?? 7A 7E 7A 78 7A 7E ?? ?? ?? ?? 7A 7F 7A 7B 7A 78 ?? ?? }
		$s123 = { 7B 7A 7B 7A 7B 79 ?? ?? 7B 79 7B 7A 7B 79 ?? ?? 7B 78 7B 79 7B 7F ?? ?? ?? ?? 7B 7F 7B 79 7B 7F ?? ?? ?? ?? 7B 7E 7B 7A 7B 79 ?? ?? }
		$s124 = { 7C 7D 7C 7D 7C 7E ?? ?? 7C 7E 7C 7D 7C 7E ?? ?? 7C 7F 7C 7E 7C 78 ?? ?? ?? ?? 7C 78 7C 7E 7C 78 ?? ?? ?? ?? 7C 79 7C 7D 7C 7E ?? ?? }
		$s125 = { 7D 7C 7D 7C 7D 7F ?? ?? 7D 7F 7D 7C 7D 7F ?? ?? 7D 7E 7D 7F 7D 79 ?? ?? ?? ?? 7D 79 7D 7F 7D 79 ?? ?? ?? ?? 7D 78 7D 7C 7D 7F ?? ?? }
		$s126 = { 7E 7F 7E 7F 7E 7C ?? ?? 7E 7C 7E 7F 7E 7C ?? ?? 7E 7D 7E 7C 7E 7A ?? ?? ?? ?? 7E 7A 7E 7C 7E 7A ?? ?? ?? ?? 7E 7B 7E 7F 7E 7C ?? ?? }
		$s127 = { 7F 7E 7F 7E 7F 7D ?? ?? 7F 7D 7F 7E 7F 7D ?? ?? 7F 7C 7F 7D 7F 7B ?? ?? ?? ?? 7F 7B 7F 7D 7F 7B ?? ?? ?? ?? 7F 7A 7F 7E 7F 7D ?? ?? }
		$s128 = { 80 81 80 81 80 82 ?? ?? 80 82 80 81 80 82 ?? ?? 80 83 80 82 80 84 ?? ?? ?? ?? 80 84 80 82 80 84 ?? ?? ?? ?? 80 85 80 81 80 82 ?? ?? }
		$s129 = { 81 80 81 80 81 83 ?? ?? 81 83 81 80 81 83 ?? ?? 81 82 81 83 81 85 ?? ?? ?? ?? 81 85 81 83 81 85 ?? ?? ?? ?? 81 84 81 80 81 83 ?? ?? }
		$s130 = { 82 83 82 83 82 80 ?? ?? 82 80 82 83 82 80 ?? ?? 82 81 82 80 82 86 ?? ?? ?? ?? 82 86 82 80 82 86 ?? ?? ?? ?? 82 87 82 83 82 80 ?? ?? }
		$s131 = { 83 82 83 82 83 81 ?? ?? 83 81 83 82 83 81 ?? ?? 83 80 83 81 83 87 ?? ?? ?? ?? 83 87 83 81 83 87 ?? ?? ?? ?? 83 86 83 82 83 81 ?? ?? }
		$s132 = { 84 85 84 85 84 86 ?? ?? 84 86 84 85 84 86 ?? ?? 84 87 84 86 84 80 ?? ?? ?? ?? 84 80 84 86 84 80 ?? ?? ?? ?? 84 81 84 85 84 86 ?? ?? }
		$s133 = { 85 84 85 84 85 87 ?? ?? 85 87 85 84 85 87 ?? ?? 85 86 85 87 85 81 ?? ?? ?? ?? 85 81 85 87 85 81 ?? ?? ?? ?? 85 80 85 84 85 87 ?? ?? }
		$s134 = { 86 87 86 87 86 84 ?? ?? 86 84 86 87 86 84 ?? ?? 86 85 86 84 86 82 ?? ?? ?? ?? 86 82 86 84 86 82 ?? ?? ?? ?? 86 83 86 87 86 84 ?? ?? }
		$s135 = { 87 86 87 86 87 85 ?? ?? 87 85 87 86 87 85 ?? ?? 87 84 87 85 87 83 ?? ?? ?? ?? 87 83 87 85 87 83 ?? ?? ?? ?? 87 82 87 86 87 85 ?? ?? }
		$s136 = { 88 89 88 89 88 8A ?? ?? 88 8A 88 89 88 8A ?? ?? 88 8B 88 8A 88 8C ?? ?? ?? ?? 88 8C 88 8A 88 8C ?? ?? ?? ?? 88 8D 88 89 88 8A ?? ?? }
		$s137 = { 89 88 89 88 89 8B ?? ?? 89 8B 89 88 89 8B ?? ?? 89 8A 89 8B 89 8D ?? ?? ?? ?? 89 8D 89 8B 89 8D ?? ?? ?? ?? 89 8C 89 88 89 8B ?? ?? }
		$s138 = { 8A 8B 8A 8B 8A 88 ?? ?? 8A 88 8A 8B 8A 88 ?? ?? 8A 89 8A 88 8A 8E ?? ?? ?? ?? 8A 8E 8A 88 8A 8E ?? ?? ?? ?? 8A 8F 8A 8B 8A 88 ?? ?? }
		$s139 = { 8B 8A 8B 8A 8B 89 ?? ?? 8B 89 8B 8A 8B 89 ?? ?? 8B 88 8B 89 8B 8F ?? ?? ?? ?? 8B 8F 8B 89 8B 8F ?? ?? ?? ?? 8B 8E 8B 8A 8B 89 ?? ?? }
		$s140 = { 8C 8D 8C 8D 8C 8E ?? ?? 8C 8E 8C 8D 8C 8E ?? ?? 8C 8F 8C 8E 8C 88 ?? ?? ?? ?? 8C 88 8C 8E 8C 88 ?? ?? ?? ?? 8C 89 8C 8D 8C 8E ?? ?? }
		$s141 = { 8D 8C 8D 8C 8D 8F ?? ?? 8D 8F 8D 8C 8D 8F ?? ?? 8D 8E 8D 8F 8D 89 ?? ?? ?? ?? 8D 89 8D 8F 8D 89 ?? ?? ?? ?? 8D 88 8D 8C 8D 8F ?? ?? }
		$s142 = { 8E 8F 8E 8F 8E 8C ?? ?? 8E 8C 8E 8F 8E 8C ?? ?? 8E 8D 8E 8C 8E 8A ?? ?? ?? ?? 8E 8A 8E 8C 8E 8A ?? ?? ?? ?? 8E 8B 8E 8F 8E 8C ?? ?? }
		$s143 = { 8F 8E 8F 8E 8F 8D ?? ?? 8F 8D 8F 8E 8F 8D ?? ?? 8F 8C 8F 8D 8F 8B ?? ?? ?? ?? 8F 8B 8F 8D 8F 8B ?? ?? ?? ?? 8F 8A 8F 8E 8F 8D ?? ?? }
		$s144 = { 90 91 90 91 90 92 ?? ?? 90 92 90 91 90 92 ?? ?? 90 93 90 92 90 94 ?? ?? ?? ?? 90 94 90 92 90 94 ?? ?? ?? ?? 90 95 90 91 90 92 ?? ?? }
		$s145 = { 91 90 91 90 91 93 ?? ?? 91 93 91 90 91 93 ?? ?? 91 92 91 93 91 95 ?? ?? ?? ?? 91 95 91 93 91 95 ?? ?? ?? ?? 91 94 91 90 91 93 ?? ?? }
		$s146 = { 92 93 92 93 92 90 ?? ?? 92 90 92 93 92 90 ?? ?? 92 91 92 90 92 96 ?? ?? ?? ?? 92 96 92 90 92 96 ?? ?? ?? ?? 92 97 92 93 92 90 ?? ?? }
		$s147 = { 93 92 93 92 93 91 ?? ?? 93 91 93 92 93 91 ?? ?? 93 90 93 91 93 97 ?? ?? ?? ?? 93 97 93 91 93 97 ?? ?? ?? ?? 93 96 93 92 93 91 ?? ?? }
		$s148 = { 94 95 94 95 94 96 ?? ?? 94 96 94 95 94 96 ?? ?? 94 97 94 96 94 90 ?? ?? ?? ?? 94 90 94 96 94 90 ?? ?? ?? ?? 94 91 94 95 94 96 ?? ?? }
		$s149 = { 95 94 95 94 95 97 ?? ?? 95 97 95 94 95 97 ?? ?? 95 96 95 97 95 91 ?? ?? ?? ?? 95 91 95 97 95 91 ?? ?? ?? ?? 95 90 95 94 95 97 ?? ?? }
		$s150 = { 96 97 96 97 96 94 ?? ?? 96 94 96 97 96 94 ?? ?? 96 95 96 94 96 92 ?? ?? ?? ?? 96 92 96 94 96 92 ?? ?? ?? ?? 96 93 96 97 96 94 ?? ?? }
		$s151 = { 97 96 97 96 97 95 ?? ?? 97 95 97 96 97 95 ?? ?? 97 94 97 95 97 93 ?? ?? ?? ?? 97 93 97 95 97 93 ?? ?? ?? ?? 97 92 97 96 97 95 ?? ?? }
		$s152 = { 98 99 98 99 98 9A ?? ?? 98 9A 98 99 98 9A ?? ?? 98 9B 98 9A 98 9C ?? ?? ?? ?? 98 9C 98 9A 98 9C ?? ?? ?? ?? 98 9D 98 99 98 9A ?? ?? }
		$s153 = { 99 98 99 98 99 9B ?? ?? 99 9B 99 98 99 9B ?? ?? 99 9A 99 9B 99 9D ?? ?? ?? ?? 99 9D 99 9B 99 9D ?? ?? ?? ?? 99 9C 99 98 99 9B ?? ?? }
		$s154 = { 9A 9B 9A 9B 9A 98 ?? ?? 9A 98 9A 9B 9A 98 ?? ?? 9A 99 9A 98 9A 9E ?? ?? ?? ?? 9A 9E 9A 98 9A 9E ?? ?? ?? ?? 9A 9F 9A 9B 9A 98 ?? ?? }
		$s155 = { 9B 9A 9B 9A 9B 99 ?? ?? 9B 99 9B 9A 9B 99 ?? ?? 9B 98 9B 99 9B 9F ?? ?? ?? ?? 9B 9F 9B 99 9B 9F ?? ?? ?? ?? 9B 9E 9B 9A 9B 99 ?? ?? }
		$s156 = { 9C 9D 9C 9D 9C 9E ?? ?? 9C 9E 9C 9D 9C 9E ?? ?? 9C 9F 9C 9E 9C 98 ?? ?? ?? ?? 9C 98 9C 9E 9C 98 ?? ?? ?? ?? 9C 99 9C 9D 9C 9E ?? ?? }
		$s157 = { 9D 9C 9D 9C 9D 9F ?? ?? 9D 9F 9D 9C 9D 9F ?? ?? 9D 9E 9D 9F 9D 99 ?? ?? ?? ?? 9D 99 9D 9F 9D 99 ?? ?? ?? ?? 9D 98 9D 9C 9D 9F ?? ?? }
		$s158 = { 9E 9F 9E 9F 9E 9C ?? ?? 9E 9C 9E 9F 9E 9C ?? ?? 9E 9D 9E 9C 9E 9A ?? ?? ?? ?? 9E 9A 9E 9C 9E 9A ?? ?? ?? ?? 9E 9B 9E 9F 9E 9C ?? ?? }
		$s159 = { 9F 9E 9F 9E 9F 9D ?? ?? 9F 9D 9F 9E 9F 9D ?? ?? 9F 9C 9F 9D 9F 9B ?? ?? ?? ?? 9F 9B 9F 9D 9F 9B ?? ?? ?? ?? 9F 9A 9F 9E 9F 9D ?? ?? }
		$s160 = { A0 A1 A0 A1 A0 A2 ?? ?? A0 A2 A0 A1 A0 A2 ?? ?? A0 A3 A0 A2 A0 A4 ?? ?? ?? ?? A0 A4 A0 A2 A0 A4 ?? ?? ?? ?? A0 A5 A0 A1 A0 A2 ?? ?? }
		$s161 = { A1 A0 A1 A0 A1 A3 ?? ?? A1 A3 A1 A0 A1 A3 ?? ?? A1 A2 A1 A3 A1 A5 ?? ?? ?? ?? A1 A5 A1 A3 A1 A5 ?? ?? ?? ?? A1 A4 A1 A0 A1 A3 ?? ?? }
		$s162 = { A2 A3 A2 A3 A2 A0 ?? ?? A2 A0 A2 A3 A2 A0 ?? ?? A2 A1 A2 A0 A2 A6 ?? ?? ?? ?? A2 A6 A2 A0 A2 A6 ?? ?? ?? ?? A2 A7 A2 A3 A2 A0 ?? ?? }
		$s163 = { A3 A2 A3 A2 A3 A1 ?? ?? A3 A1 A3 A2 A3 A1 ?? ?? A3 A0 A3 A1 A3 A7 ?? ?? ?? ?? A3 A7 A3 A1 A3 A7 ?? ?? ?? ?? A3 A6 A3 A2 A3 A1 ?? ?? }
		$s164 = { A4 A5 A4 A5 A4 A6 ?? ?? A4 A6 A4 A5 A4 A6 ?? ?? A4 A7 A4 A6 A4 A0 ?? ?? ?? ?? A4 A0 A4 A6 A4 A0 ?? ?? ?? ?? A4 A1 A4 A5 A4 A6 ?? ?? }
		$s165 = { A5 A4 A5 A4 A5 A7 ?? ?? A5 A7 A5 A4 A5 A7 ?? ?? A5 A6 A5 A7 A5 A1 ?? ?? ?? ?? A5 A1 A5 A7 A5 A1 ?? ?? ?? ?? A5 A0 A5 A4 A5 A7 ?? ?? }
		$s166 = { A6 A7 A6 A7 A6 A4 ?? ?? A6 A4 A6 A7 A6 A4 ?? ?? A6 A5 A6 A4 A6 A2 ?? ?? ?? ?? A6 A2 A6 A4 A6 A2 ?? ?? ?? ?? A6 A3 A6 A7 A6 A4 ?? ?? }
		$s167 = { A7 A6 A7 A6 A7 A5 ?? ?? A7 A5 A7 A6 A7 A5 ?? ?? A7 A4 A7 A5 A7 A3 ?? ?? ?? ?? A7 A3 A7 A5 A7 A3 ?? ?? ?? ?? A7 A2 A7 A6 A7 A5 ?? ?? }
		$s168 = { A8 A9 A8 A9 A8 AA ?? ?? A8 AA A8 A9 A8 AA ?? ?? A8 AB A8 AA A8 AC ?? ?? ?? ?? A8 AC A8 AA A8 AC ?? ?? ?? ?? A8 AD A8 A9 A8 AA ?? ?? }
		$s169 = { A9 A8 A9 A8 A9 AB ?? ?? A9 AB A9 A8 A9 AB ?? ?? A9 AA A9 AB A9 AD ?? ?? ?? ?? A9 AD A9 AB A9 AD ?? ?? ?? ?? A9 AC A9 A8 A9 AB ?? ?? }
		$s170 = { AA AB AA AB AA A8 ?? ?? AA A8 AA AB AA A8 ?? ?? AA A9 AA A8 AA AE ?? ?? ?? ?? AA AE AA A8 AA AE ?? ?? ?? ?? AA AF AA AB AA A8 ?? ?? }
		$s171 = { AB AA AB AA AB A9 ?? ?? AB A9 AB AA AB A9 ?? ?? AB A8 AB A9 AB AF ?? ?? ?? ?? AB AF AB A9 AB AF ?? ?? ?? ?? AB AE AB AA AB A9 ?? ?? }
		$s172 = { AC AD AC AD AC AE ?? ?? AC AE AC AD AC AE ?? ?? AC AF AC AE AC A8 ?? ?? ?? ?? AC A8 AC AE AC A8 ?? ?? ?? ?? AC A9 AC AD AC AE ?? ?? }
		$s173 = { AD AC AD AC AD AF ?? ?? AD AF AD AC AD AF ?? ?? AD AE AD AF AD A9 ?? ?? ?? ?? AD A9 AD AF AD A9 ?? ?? ?? ?? AD A8 AD AC AD AF ?? ?? }
		$s174 = { AE AF AE AF AE AC ?? ?? AE AC AE AF AE AC ?? ?? AE AD AE AC AE AA ?? ?? ?? ?? AE AA AE AC AE AA ?? ?? ?? ?? AE AB AE AF AE AC ?? ?? }
		$s175 = { AF AE AF AE AF AD ?? ?? AF AD AF AE AF AD ?? ?? AF AC AF AD AF AB ?? ?? ?? ?? AF AB AF AD AF AB ?? ?? ?? ?? AF AA AF AE AF AD ?? ?? }
		$s176 = { B0 B1 B0 B1 B0 B2 ?? ?? B0 B2 B0 B1 B0 B2 ?? ?? B0 B3 B0 B2 B0 B4 ?? ?? ?? ?? B0 B4 B0 B2 B0 B4 ?? ?? ?? ?? B0 B5 B0 B1 B0 B2 ?? ?? }
		$s177 = { B1 B0 B1 B0 B1 B3 ?? ?? B1 B3 B1 B0 B1 B3 ?? ?? B1 B2 B1 B3 B1 B5 ?? ?? ?? ?? B1 B5 B1 B3 B1 B5 ?? ?? ?? ?? B1 B4 B1 B0 B1 B3 ?? ?? }
		$s178 = { B2 B3 B2 B3 B2 B0 ?? ?? B2 B0 B2 B3 B2 B0 ?? ?? B2 B1 B2 B0 B2 B6 ?? ?? ?? ?? B2 B6 B2 B0 B2 B6 ?? ?? ?? ?? B2 B7 B2 B3 B2 B0 ?? ?? }
		$s179 = { B3 B2 B3 B2 B3 B1 ?? ?? B3 B1 B3 B2 B3 B1 ?? ?? B3 B0 B3 B1 B3 B7 ?? ?? ?? ?? B3 B7 B3 B1 B3 B7 ?? ?? ?? ?? B3 B6 B3 B2 B3 B1 ?? ?? }
		$s180 = { B4 B5 B4 B5 B4 B6 ?? ?? B4 B6 B4 B5 B4 B6 ?? ?? B4 B7 B4 B6 B4 B0 ?? ?? ?? ?? B4 B0 B4 B6 B4 B0 ?? ?? ?? ?? B4 B1 B4 B5 B4 B6 ?? ?? }
		$s181 = { B5 B4 B5 B4 B5 B7 ?? ?? B5 B7 B5 B4 B5 B7 ?? ?? B5 B6 B5 B7 B5 B1 ?? ?? ?? ?? B5 B1 B5 B7 B5 B1 ?? ?? ?? ?? B5 B0 B5 B4 B5 B7 ?? ?? }
		$s182 = { B6 B7 B6 B7 B6 B4 ?? ?? B6 B4 B6 B7 B6 B4 ?? ?? B6 B5 B6 B4 B6 B2 ?? ?? ?? ?? B6 B2 B6 B4 B6 B2 ?? ?? ?? ?? B6 B3 B6 B7 B6 B4 ?? ?? }
		$s183 = { B7 B6 B7 B6 B7 B5 ?? ?? B7 B5 B7 B6 B7 B5 ?? ?? B7 B4 B7 B5 B7 B3 ?? ?? ?? ?? B7 B3 B7 B5 B7 B3 ?? ?? ?? ?? B7 B2 B7 B6 B7 B5 ?? ?? }
		$s184 = { B8 B9 B8 B9 B8 BA ?? ?? B8 BA B8 B9 B8 BA ?? ?? B8 BB B8 BA B8 BC ?? ?? ?? ?? B8 BC B8 BA B8 BC ?? ?? ?? ?? B8 BD B8 B9 B8 BA ?? ?? }
		$s185 = { B9 B8 B9 B8 B9 BB ?? ?? B9 BB B9 B8 B9 BB ?? ?? B9 BA B9 BB B9 BD ?? ?? ?? ?? B9 BD B9 BB B9 BD ?? ?? ?? ?? B9 BC B9 B8 B9 BB ?? ?? }
		$s186 = { BA BB BA BB BA B8 ?? ?? BA B8 BA BB BA B8 ?? ?? BA B9 BA B8 BA BE ?? ?? ?? ?? BA BE BA B8 BA BE ?? ?? ?? ?? BA BF BA BB BA B8 ?? ?? }
		$s187 = { BB BA BB BA BB B9 ?? ?? BB B9 BB BA BB B9 ?? ?? BB B8 BB B9 BB BF ?? ?? ?? ?? BB BF BB B9 BB BF ?? ?? ?? ?? BB BE BB BA BB B9 ?? ?? }
		$s188 = { BC BD BC BD BC BE ?? ?? BC BE BC BD BC BE ?? ?? BC BF BC BE BC B8 ?? ?? ?? ?? BC B8 BC BE BC B8 ?? ?? ?? ?? BC B9 BC BD BC BE ?? ?? }
		$s189 = { BD BC BD BC BD BF ?? ?? BD BF BD BC BD BF ?? ?? BD BE BD BF BD B9 ?? ?? ?? ?? BD B9 BD BF BD B9 ?? ?? ?? ?? BD B8 BD BC BD BF ?? ?? }
		$s190 = { BE BF BE BF BE BC ?? ?? BE BC BE BF BE BC ?? ?? BE BD BE BC BE BA ?? ?? ?? ?? BE BA BE BC BE BA ?? ?? ?? ?? BE BB BE BF BE BC ?? ?? }
		$s191 = { BF BE BF BE BF BD ?? ?? BF BD BF BE BF BD ?? ?? BF BC BF BD BF BB ?? ?? ?? ?? BF BB BF BD BF BB ?? ?? ?? ?? BF BA BF BE BF BD ?? ?? }
		$s192 = { C0 C1 C0 C1 C0 C2 ?? ?? C0 C2 C0 C1 C0 C2 ?? ?? C0 C3 C0 C2 C0 C4 ?? ?? ?? ?? C0 C4 C0 C2 C0 C4 ?? ?? ?? ?? C0 C5 C0 C1 C0 C2 ?? ?? }
		$s193 = { C1 C0 C1 C0 C1 C3 ?? ?? C1 C3 C1 C0 C1 C3 ?? ?? C1 C2 C1 C3 C1 C5 ?? ?? ?? ?? C1 C5 C1 C3 C1 C5 ?? ?? ?? ?? C1 C4 C1 C0 C1 C3 ?? ?? }
		$s194 = { C2 C3 C2 C3 C2 C0 ?? ?? C2 C0 C2 C3 C2 C0 ?? ?? C2 C1 C2 C0 C2 C6 ?? ?? ?? ?? C2 C6 C2 C0 C2 C6 ?? ?? ?? ?? C2 C7 C2 C3 C2 C0 ?? ?? }
		$s195 = { C3 C2 C3 C2 C3 C1 ?? ?? C3 C1 C3 C2 C3 C1 ?? ?? C3 C0 C3 C1 C3 C7 ?? ?? ?? ?? C3 C7 C3 C1 C3 C7 ?? ?? ?? ?? C3 C6 C3 C2 C3 C1 ?? ?? }
		$s196 = { C4 C5 C4 C5 C4 C6 ?? ?? C4 C6 C4 C5 C4 C6 ?? ?? C4 C7 C4 C6 C4 C0 ?? ?? ?? ?? C4 C0 C4 C6 C4 C0 ?? ?? ?? ?? C4 C1 C4 C5 C4 C6 ?? ?? }
		$s197 = { C5 C4 C5 C4 C5 C7 ?? ?? C5 C7 C5 C4 C5 C7 ?? ?? C5 C6 C5 C7 C5 C1 ?? ?? ?? ?? C5 C1 C5 C7 C5 C1 ?? ?? ?? ?? C5 C0 C5 C4 C5 C7 ?? ?? }
		$s198 = { C6 C7 C6 C7 C6 C4 ?? ?? C6 C4 C6 C7 C6 C4 ?? ?? C6 C5 C6 C4 C6 C2 ?? ?? ?? ?? C6 C2 C6 C4 C6 C2 ?? ?? ?? ?? C6 C3 C6 C7 C6 C4 ?? ?? }
		$s199 = { C7 C6 C7 C6 C7 C5 ?? ?? C7 C5 C7 C6 C7 C5 ?? ?? C7 C4 C7 C5 C7 C3 ?? ?? ?? ?? C7 C3 C7 C5 C7 C3 ?? ?? ?? ?? C7 C2 C7 C6 C7 C5 ?? ?? }
		$s200 = { C8 C9 C8 C9 C8 CA ?? ?? C8 CA C8 C9 C8 CA ?? ?? C8 CB C8 CA C8 CC ?? ?? ?? ?? C8 CC C8 CA C8 CC ?? ?? ?? ?? C8 CD C8 C9 C8 CA ?? ?? }
		$s201 = { C9 C8 C9 C8 C9 CB ?? ?? C9 CB C9 C8 C9 CB ?? ?? C9 CA C9 CB C9 CD ?? ?? ?? ?? C9 CD C9 CB C9 CD ?? ?? ?? ?? C9 CC C9 C8 C9 CB ?? ?? }
		$s202 = { CA CB CA CB CA C8 ?? ?? CA C8 CA CB CA C8 ?? ?? CA C9 CA C8 CA CE ?? ?? ?? ?? CA CE CA C8 CA CE ?? ?? ?? ?? CA CF CA CB CA C8 ?? ?? }
		$s203 = { CB CA CB CA CB C9 ?? ?? CB C9 CB CA CB C9 ?? ?? CB C8 CB C9 CB CF ?? ?? ?? ?? CB CF CB C9 CB CF ?? ?? ?? ?? CB CE CB CA CB C9 ?? ?? }
		$s204 = { CC CD CC CD CC CE ?? ?? CC CE CC CD CC CE ?? ?? CC CF CC CE CC C8 ?? ?? ?? ?? CC C8 CC CE CC C8 ?? ?? ?? ?? CC C9 CC CD CC CE ?? ?? }
		$s205 = { CD CC CD CC CD CF ?? ?? CD CF CD CC CD CF ?? ?? CD CE CD CF CD C9 ?? ?? ?? ?? CD C9 CD CF CD C9 ?? ?? ?? ?? CD C8 CD CC CD CF ?? ?? }
		$s206 = { CE CF CE CF CE CC ?? ?? CE CC CE CF CE CC ?? ?? CE CD CE CC CE CA ?? ?? ?? ?? CE CA CE CC CE CA ?? ?? ?? ?? CE CB CE CF CE CC ?? ?? }
		$s207 = { CF CE CF CE CF CD ?? ?? CF CD CF CE CF CD ?? ?? CF CC CF CD CF CB ?? ?? ?? ?? CF CB CF CD CF CB ?? ?? ?? ?? CF CA CF CE CF CD ?? ?? }
		$s208 = { D0 D1 D0 D1 D0 D2 ?? ?? D0 D2 D0 D1 D0 D2 ?? ?? D0 D3 D0 D2 D0 D4 ?? ?? ?? ?? D0 D4 D0 D2 D0 D4 ?? ?? ?? ?? D0 D5 D0 D1 D0 D2 ?? ?? }
		$s209 = { D1 D0 D1 D0 D1 D3 ?? ?? D1 D3 D1 D0 D1 D3 ?? ?? D1 D2 D1 D3 D1 D5 ?? ?? ?? ?? D1 D5 D1 D3 D1 D5 ?? ?? ?? ?? D1 D4 D1 D0 D1 D3 ?? ?? }
		$s210 = { D2 D3 D2 D3 D2 D0 ?? ?? D2 D0 D2 D3 D2 D0 ?? ?? D2 D1 D2 D0 D2 D6 ?? ?? ?? ?? D2 D6 D2 D0 D2 D6 ?? ?? ?? ?? D2 D7 D2 D3 D2 D0 ?? ?? }
		$s211 = { D3 D2 D3 D2 D3 D1 ?? ?? D3 D1 D3 D2 D3 D1 ?? ?? D3 D0 D3 D1 D3 D7 ?? ?? ?? ?? D3 D7 D3 D1 D3 D7 ?? ?? ?? ?? D3 D6 D3 D2 D3 D1 ?? ?? }
		$s212 = { D4 D5 D4 D5 D4 D6 ?? ?? D4 D6 D4 D5 D4 D6 ?? ?? D4 D7 D4 D6 D4 D0 ?? ?? ?? ?? D4 D0 D4 D6 D4 D0 ?? ?? ?? ?? D4 D1 D4 D5 D4 D6 ?? ?? }
		$s213 = { D5 D4 D5 D4 D5 D7 ?? ?? D5 D7 D5 D4 D5 D7 ?? ?? D5 D6 D5 D7 D5 D1 ?? ?? ?? ?? D5 D1 D5 D7 D5 D1 ?? ?? ?? ?? D5 D0 D5 D4 D5 D7 ?? ?? }
		$s214 = { D6 D7 D6 D7 D6 D4 ?? ?? D6 D4 D6 D7 D6 D4 ?? ?? D6 D5 D6 D4 D6 D2 ?? ?? ?? ?? D6 D2 D6 D4 D6 D2 ?? ?? ?? ?? D6 D3 D6 D7 D6 D4 ?? ?? }
		$s215 = { D7 D6 D7 D6 D7 D5 ?? ?? D7 D5 D7 D6 D7 D5 ?? ?? D7 D4 D7 D5 D7 D3 ?? ?? ?? ?? D7 D3 D7 D5 D7 D3 ?? ?? ?? ?? D7 D2 D7 D6 D7 D5 ?? ?? }
		$s216 = { D8 D9 D8 D9 D8 DA ?? ?? D8 DA D8 D9 D8 DA ?? ?? D8 DB D8 DA D8 DC ?? ?? ?? ?? D8 DC D8 DA D8 DC ?? ?? ?? ?? D8 DD D8 D9 D8 DA ?? ?? }
		$s217 = { D9 D8 D9 D8 D9 DB ?? ?? D9 DB D9 D8 D9 DB ?? ?? D9 DA D9 DB D9 DD ?? ?? ?? ?? D9 DD D9 DB D9 DD ?? ?? ?? ?? D9 DC D9 D8 D9 DB ?? ?? }
		$s218 = { DA DB DA DB DA D8 ?? ?? DA D8 DA DB DA D8 ?? ?? DA D9 DA D8 DA DE ?? ?? ?? ?? DA DE DA D8 DA DE ?? ?? ?? ?? DA DF DA DB DA D8 ?? ?? }
		$s219 = { DB DA DB DA DB D9 ?? ?? DB D9 DB DA DB D9 ?? ?? DB D8 DB D9 DB DF ?? ?? ?? ?? DB DF DB D9 DB DF ?? ?? ?? ?? DB DE DB DA DB D9 ?? ?? }
		$s220 = { DC DD DC DD DC DE ?? ?? DC DE DC DD DC DE ?? ?? DC DF DC DE DC D8 ?? ?? ?? ?? DC D8 DC DE DC D8 ?? ?? ?? ?? DC D9 DC DD DC DE ?? ?? }
		$s221 = { DD DC DD DC DD DF ?? ?? DD DF DD DC DD DF ?? ?? DD DE DD DF DD D9 ?? ?? ?? ?? DD D9 DD DF DD D9 ?? ?? ?? ?? DD D8 DD DC DD DF ?? ?? }
		$s222 = { DE DF DE DF DE DC ?? ?? DE DC DE DF DE DC ?? ?? DE DD DE DC DE DA ?? ?? ?? ?? DE DA DE DC DE DA ?? ?? ?? ?? DE DB DE DF DE DC ?? ?? }
		$s223 = { DF DE DF DE DF DD ?? ?? DF DD DF DE DF DD ?? ?? DF DC DF DD DF DB ?? ?? ?? ?? DF DB DF DD DF DB ?? ?? ?? ?? DF DA DF DE DF DD ?? ?? }
		$s224 = { E0 E1 E0 E1 E0 E2 ?? ?? E0 E2 E0 E1 E0 E2 ?? ?? E0 E3 E0 E2 E0 E4 ?? ?? ?? ?? E0 E4 E0 E2 E0 E4 ?? ?? ?? ?? E0 E5 E0 E1 E0 E2 ?? ?? }
		$s225 = { E1 E0 E1 E0 E1 E3 ?? ?? E1 E3 E1 E0 E1 E3 ?? ?? E1 E2 E1 E3 E1 E5 ?? ?? ?? ?? E1 E5 E1 E3 E1 E5 ?? ?? ?? ?? E1 E4 E1 E0 E1 E3 ?? ?? }
		$s226 = { E2 E3 E2 E3 E2 E0 ?? ?? E2 E0 E2 E3 E2 E0 ?? ?? E2 E1 E2 E0 E2 E6 ?? ?? ?? ?? E2 E6 E2 E0 E2 E6 ?? ?? ?? ?? E2 E7 E2 E3 E2 E0 ?? ?? }
		$s227 = { E3 E2 E3 E2 E3 E1 ?? ?? E3 E1 E3 E2 E3 E1 ?? ?? E3 E0 E3 E1 E3 E7 ?? ?? ?? ?? E3 E7 E3 E1 E3 E7 ?? ?? ?? ?? E3 E6 E3 E2 E3 E1 ?? ?? }
		$s228 = { E4 E5 E4 E5 E4 E6 ?? ?? E4 E6 E4 E5 E4 E6 ?? ?? E4 E7 E4 E6 E4 E0 ?? ?? ?? ?? E4 E0 E4 E6 E4 E0 ?? ?? ?? ?? E4 E1 E4 E5 E4 E6 ?? ?? }
		$s229 = { E5 E4 E5 E4 E5 E7 ?? ?? E5 E7 E5 E4 E5 E7 ?? ?? E5 E6 E5 E7 E5 E1 ?? ?? ?? ?? E5 E1 E5 E7 E5 E1 ?? ?? ?? ?? E5 E0 E5 E4 E5 E7 ?? ?? }
		$s230 = { E6 E7 E6 E7 E6 E4 ?? ?? E6 E4 E6 E7 E6 E4 ?? ?? E6 E5 E6 E4 E6 E2 ?? ?? ?? ?? E6 E2 E6 E4 E6 E2 ?? ?? ?? ?? E6 E3 E6 E7 E6 E4 ?? ?? }
		$s231 = { E7 E6 E7 E6 E7 E5 ?? ?? E7 E5 E7 E6 E7 E5 ?? ?? E7 E4 E7 E5 E7 E3 ?? ?? ?? ?? E7 E3 E7 E5 E7 E3 ?? ?? ?? ?? E7 E2 E7 E6 E7 E5 ?? ?? }
		$s232 = { E8 E9 E8 E9 E8 EA ?? ?? E8 EA E8 E9 E8 EA ?? ?? E8 EB E8 EA E8 EC ?? ?? ?? ?? E8 EC E8 EA E8 EC ?? ?? ?? ?? E8 ED E8 E9 E8 EA ?? ?? }
		$s233 = { E9 E8 E9 E8 E9 EB ?? ?? E9 EB E9 E8 E9 EB ?? ?? E9 EA E9 EB E9 ED ?? ?? ?? ?? E9 ED E9 EB E9 ED ?? ?? ?? ?? E9 EC E9 E8 E9 EB ?? ?? }
		$s234 = { EA EB EA EB EA E8 ?? ?? EA E8 EA EB EA E8 ?? ?? EA E9 EA E8 EA EE ?? ?? ?? ?? EA EE EA E8 EA EE ?? ?? ?? ?? EA EF EA EB EA E8 ?? ?? }
		$s235 = { EB EA EB EA EB E9 ?? ?? EB E9 EB EA EB E9 ?? ?? EB E8 EB E9 EB EF ?? ?? ?? ?? EB EF EB E9 EB EF ?? ?? ?? ?? EB EE EB EA EB E9 ?? ?? }
		$s236 = { EC ED EC ED EC EE ?? ?? EC EE EC ED EC EE ?? ?? EC EF EC EE EC E8 ?? ?? ?? ?? EC E8 EC EE EC E8 ?? ?? ?? ?? EC E9 EC ED EC EE ?? ?? }
		$s237 = { ED EC ED EC ED EF ?? ?? ED EF ED EC ED EF ?? ?? ED EE ED EF ED E9 ?? ?? ?? ?? ED E9 ED EF ED E9 ?? ?? ?? ?? ED E8 ED EC ED EF ?? ?? }
		$s238 = { EE EF EE EF EE EC ?? ?? EE EC EE EF EE EC ?? ?? EE ED EE EC EE EA ?? ?? ?? ?? EE EA EE EC EE EA ?? ?? ?? ?? EE EB EE EF EE EC ?? ?? }
		$s239 = { EF EE EF EE EF ED ?? ?? EF ED EF EE EF ED ?? ?? EF EC EF ED EF EB ?? ?? ?? ?? EF EB EF ED EF EB ?? ?? ?? ?? EF EA EF EE EF ED ?? ?? }
		$s240 = { F0 F1 F0 F1 F0 F2 ?? ?? F0 F2 F0 F1 F0 F2 ?? ?? F0 F3 F0 F2 F0 F4 ?? ?? ?? ?? F0 F4 F0 F2 F0 F4 ?? ?? ?? ?? F0 F5 F0 F1 F0 F2 ?? ?? }
		$s241 = { F1 F0 F1 F0 F1 F3 ?? ?? F1 F3 F1 F0 F1 F3 ?? ?? F1 F2 F1 F3 F1 F5 ?? ?? ?? ?? F1 F5 F1 F3 F1 F5 ?? ?? ?? ?? F1 F4 F1 F0 F1 F3 ?? ?? }
		$s242 = { F2 F3 F2 F3 F2 F0 ?? ?? F2 F0 F2 F3 F2 F0 ?? ?? F2 F1 F2 F0 F2 F6 ?? ?? ?? ?? F2 F6 F2 F0 F2 F6 ?? ?? ?? ?? F2 F7 F2 F3 F2 F0 ?? ?? }
		$s243 = { F3 F2 F3 F2 F3 F1 ?? ?? F3 F1 F3 F2 F3 F1 ?? ?? F3 F0 F3 F1 F3 F7 ?? ?? ?? ?? F3 F7 F3 F1 F3 F7 ?? ?? ?? ?? F3 F6 F3 F2 F3 F1 ?? ?? }
		$s244 = { F4 F5 F4 F5 F4 F6 ?? ?? F4 F6 F4 F5 F4 F6 ?? ?? F4 F7 F4 F6 F4 F0 ?? ?? ?? ?? F4 F0 F4 F6 F4 F0 ?? ?? ?? ?? F4 F1 F4 F5 F4 F6 ?? ?? }
		$s245 = { F5 F4 F5 F4 F5 F7 ?? ?? F5 F7 F5 F4 F5 F7 ?? ?? F5 F6 F5 F7 F5 F1 ?? ?? ?? ?? F5 F1 F5 F7 F5 F1 ?? ?? ?? ?? F5 F0 F5 F4 F5 F7 ?? ?? }
		$s246 = { F6 F7 F6 F7 F6 F4 ?? ?? F6 F4 F6 F7 F6 F4 ?? ?? F6 F5 F6 F4 F6 F2 ?? ?? ?? ?? F6 F2 F6 F4 F6 F2 ?? ?? ?? ?? F6 F3 F6 F7 F6 F4 ?? ?? }
		$s247 = { F7 F6 F7 F6 F7 F5 ?? ?? F7 F5 F7 F6 F7 F5 ?? ?? F7 F4 F7 F5 F7 F3 ?? ?? ?? ?? F7 F3 F7 F5 F7 F3 ?? ?? ?? ?? F7 F2 F7 F6 F7 F5 ?? ?? }
		$s248 = { F8 F9 F8 F9 F8 FA ?? ?? F8 FA F8 F9 F8 FA ?? ?? F8 FB F8 FA F8 FC ?? ?? ?? ?? F8 FC F8 FA F8 FC ?? ?? ?? ?? F8 FD F8 F9 F8 FA ?? ?? }
		$s249 = { F9 F8 F9 F8 F9 FB ?? ?? F9 FB F9 F8 F9 FB ?? ?? F9 FA F9 FB F9 FD ?? ?? ?? ?? F9 FD F9 FB F9 FD ?? ?? ?? ?? F9 FC F9 F8 F9 FB ?? ?? }
		$s250 = { FA FB FA FB FA F8 ?? ?? FA F8 FA FB FA F8 ?? ?? FA F9 FA F8 FA FE ?? ?? ?? ?? FA FE FA F8 FA FE ?? ?? ?? ?? FA FF FA FB FA F8 ?? ?? }
		$s251 = { FB FA FB FA FB F9 ?? ?? FB F9 FB FA FB F9 ?? ?? FB F8 FB F9 FB FF ?? ?? ?? ?? FB FF FB F9 FB FF ?? ?? ?? ?? FB FE FB FA FB F9 ?? ?? }
		$s252 = { FC FD FC FD FC FE ?? ?? FC FE FC FD FC FE ?? ?? FC FF FC FE FC F8 ?? ?? ?? ?? FC F8 FC FE FC F8 ?? ?? ?? ?? FC F9 FC FD FC FE ?? ?? }
		$s253 = { FD FC FD FC FD FF ?? ?? FD FF FD FC FD FF ?? ?? FD FE FD FF FD F9 ?? ?? ?? ?? FD F9 FD FF FD F9 ?? ?? ?? ?? FD F8 FD FC FD FF ?? ?? }
		$s254 = { FE FF FE FF FE FC ?? ?? FE FC FE FF FE FC ?? ?? FE FD FE FC FE FA ?? ?? ?? ?? FE FA FE FC FE FA ?? ?? ?? ?? FE FB FE FF FE FC ?? ?? }
		$s255 = { FF FE FF FE FF FD ?? ?? FF FD FF FE FF FD ?? ?? FF FC FF FD FF FB ?? ?? ?? ?? FF FB FF FD FF FB ?? ?? ?? ?? FF FA FF FE FF FD ?? ?? }
		
		$fp1 = "ICSharpCode.Decompiler" wide
    condition:
		any of ($s*) and not 1 of ($fp*)
}

rule CobaltStrike_MZ_Launcher {
	meta:
		description = "Detects CobaltStrike MZ header ReflectiveLoader launcher"
		author = "yara@s3c.za.net"
		date = "2021-07-08"
		uuid = "461a4741-11c5-53d9-b8e1-52d64cfe755b"
    strings:
        $mz_launcher = { 4D 5A 41 52 55 48 89 E5 48 81 EC 20 00 00 00 48 8D 1D }
	condition:
		$mz_launcher
}

rule CobaltStrike_Unmodifed_Beacon {
	meta:
		description = "Detects unmodified CobaltStrike beacon DLL"
		author = "yara@s3c.za.net"
		date = "2019-08-16"
		uuid = "8eeb03f9-9698-5a46-b45b-224d5c3f3df7"
	strings:
		$loader_export = "ReflectiveLoader"
		$exportname = "beacon.dll"
	condition:
		all of them
}
