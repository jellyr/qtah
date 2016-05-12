-- This file is part of Qtah.
--
-- Copyright 2016 Bryan Gardiner <bog@khumba.net>
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

module Graphics.UI.Qtah.Internal.Interface.Gui.QExposeEvent (
  aModule,
  ) where

import Foreign.Hoppy.Generator.Spec (
  Type (TObj),
  addReqIncludes,
  ident,
  includeStd,
  makeClass,
  mkConstMethod,
  mkCtor,
  )
import Graphics.UI.Qtah.Internal.Generator.Types
import Graphics.UI.Qtah.Internal.Interface.Core.QEvent (c_QEvent)
import Graphics.UI.Qtah.Internal.Interface.Gui.QRegion (c_QRegion)

{-# ANN module "HLint: ignore Use camelCase" #-}

minVersion = [5, 0]

aModule =
  AQtModule $
  makeQtModuleWithMinVersion ["Gui", "QExposeEvent"] minVersion
  [ QtExportEvent c_QExposeEvent ]

c_QExposeEvent =
  addReqIncludes [includeStd "QExposeEvent"] $
  makeClass (ident "QExposeEvent") Nothing [c_QEvent]
  [ mkCtor "new" [TObj c_QRegion]
  ]
  [ mkConstMethod "region" [] $ TObj c_QRegion
  ]
