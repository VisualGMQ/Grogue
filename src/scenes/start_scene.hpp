#pragma once

#include "engine/engine.hpp"
#include "map/map_generate.hpp"

#include "system/maptile_render.hpp"
#include "system/transform_update.hpp"
#include "system/sprite_render.hpp"
#include "system/mapobject_render.hpp"
#include "system/hint_arrow.hpp"
#include "system/controller_update.hpp"
#include "system/ui_render.hpp"
#include "system/sort_monster.hpp"
#include "system/life_ui_render.hpp"
#include "system/collision.hpp"
#include "system/collision_outline.hpp"
#include "system/physical.hpp"
#include "system/physical_clear.hpp"

#include "others/localization.hpp"
#include "others/human_create.hpp"
#include "others/data.hpp"
#include "others/tilesheet_loader.hpp"
#include "others/object_reader.hpp"
#include "scripts/controller.hpp"
#include "ui/backpack_panel.hpp"

class StartScene final : public engine::Scene {
public:
    StartScene(const std::string& name): engine::Scene(name) {}

    void OnInit() override;
    void OnQuit() override;

private:
    void initMap();
    void attachSystems();
};