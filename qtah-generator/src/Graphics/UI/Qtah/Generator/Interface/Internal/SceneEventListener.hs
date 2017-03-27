-- This file is part of Qtah.
--
-- Copyright 2016-2017 Bryan Gardiner <bog@khumba.net>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

module Graphics.UI.Qtah.Generator.Interface.Internal.SceneEventListener (
  aModule,
  ) where

import Foreign.Hoppy.Generator.Spec (
  Export (ExportClass),
  addReqIncludes,
  classSetEntityPrefix,
  ident2,
  includeLocal,
  makeClass,
  mkCtor,
  )
import Foreign.Hoppy.Generator.Types (callbackT, intT, ptrT)
import Graphics.UI.Qtah.Generator.Interface.Widgets.QGraphicsItem (c_QGraphicsItem)
import Graphics.UI.Qtah.Generator.Interface.Internal.Callback (cb_PtrQGraphicsItemPtrQEventBool)
import Graphics.UI.Qtah.Generator.Module (AModule (AQtModule), makeQtModule)
import Graphics.UI.Qtah.Generator.Types

{-# ANN module "HLint: ignore Use camelCase" #-}

aModule =
  AQtModule $
  makeQtModule ["Internal", "SceneEventListener"]
  [ QtExport $ ExportClass c_SceneEventListener ]

c_SceneEventListener =
  addReqIncludes [includeLocal "event.hpp"] $
  classSetEntityPrefix "" $
  makeClass (ident2 "qtah" "event" "SceneEventListener") Nothing [c_QGraphicsItem]
  [ mkCtor "new" [callbackT cb_PtrQGraphicsItemPtrQEventBool, ptrT intT]
  ]
