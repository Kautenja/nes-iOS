//  Program:      nes-py
//  File:         mapper_UxROM.hpp
//  Description:  An implementation of the UxROM mapper
//
//  Copyright (c) 2019 Christian Kauten. All rights reserved.
//

#ifndef MAPPERUXROM_HPP
#define MAPPERUXROM_HPP

#include "common.hpp"
#include "mapper.hpp"

class MapperUxROM : public Mapper {

private:
    /// whether the cartridge use character RAM
    bool has_character_ram;
    /// the pointer to the last bank
    const NES_Byte* last_bank_pointer;
    /// TODO: what is this?
    NES_Address select_prg;
    /// The character RAM on the mapper
    std::vector<NES_Byte> character_ram;

public:
    /// Create a new mapper with a cartridge.
    ///
    /// @param cart a reference to a cartridge for the mapper to access
    ///
    MapperUxROM(Cartridge& cart);

    /// Read a byte from the PRG RAM.
    ///
    /// @param address the 16-bit address of the byte to read
    /// @return the byte located at the given address in PRG RAM
    ///
    NES_Byte readPRG (NES_Address address);

    /// Write a byte to an address in the PRG RAM.
    ///
    /// @param address the 16-bit address to write to
    /// @param value the byte to write to the given address
    ///
    inline void writePRG (NES_Address address, NES_Byte value) { select_prg = value; };

    /// Read a byte from the CHR RAM.
    ///
    /// @param address the 16-bit address of the byte to read
    /// @return the byte located at the given address in CHR RAM
    ///
    NES_Byte readCHR (NES_Address address);

    /// Write a byte to an address in the CHR RAM.
    ///
    /// @param address the 16-bit address to write to
    /// @param value the byte to write to the given address
    ///
    void writeCHR (NES_Address address, NES_Byte value);

    /// Return the page pointer for the given address.
    ///
    /// @param address the address of the page pointer to get
    /// @return the page pointer at the given address
    ///
    const NES_Byte* getPagePtr(NES_Address address);

};

#endif // MAPPERUXROM_HPP
