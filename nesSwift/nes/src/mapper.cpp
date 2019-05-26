//  Program:      nes-py
//  File:         mapper.cpp
//  Description:  This class provides an abstraction of an NES cartridge mapper
//
//  Copyright (c) 2019 Christian Kauten. All rights reserved.
//

#include "mapper.hpp"
#include "mapper_NROM.hpp"
#include "mapper_SxROM.hpp"
#include "mapper_UxROM.hpp"
#include "mapper_CNROM.hpp"

Mapper* Mapper::create(Cartridge& game, std::function<void(void)> mirroring_cb) {
    switch (static_cast<Mapper::Type>(game.getMapper())) {
        case NROM:
            return new MapperNROM(game);
        case SxROM:
            return new MapperSxROM(game, mirroring_cb);
        case UxROM:
            return new MapperUxROM(game);
        case CNROM:
            return new MapperCNROM(game);
        default:
            return nullptr;
    }
}
