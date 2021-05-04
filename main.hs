{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
import Yesod
import Yesod.Static

data App = App {getStatic :: Static}

mkYesod "App" [parseRoutes|
/ HomeR GET
/ComputerScience CSR GET
/Mathematics MathR GET
/Language LangR GET
/Art ArtR GET
/ComputerScience/TypeTheory TypesR GET
/ComputerScience/FunctionalProgramming FPR GET
/ComputerSceince/OSDesign OSDesignR GET
/ComputerScience/Algorithms AlgoR GET
/Mathematics/Topology TopologyR GET
/Mathematics/Logic LogicR GET
/Mathematics/CategoryTheory CategoryR GET
/Mathematics/Topoi/ TopoiR GET
/Language/Spanish ESR GET
/Language/French FRR GET
/Language/Esperanto EOR GET
/Language/Etruscan ETTR GET
/Language/Seri SEIR GET
/Artwork/Origami OrigamiR GET
/Artwork/Calligraphy CalligraphyR GET
/Artwork/Fashion FashionR GET
/static StaticR Static getStatic
|]

instance Yesod App

--Home resource, move the CSS to a separate stylesheet, use lucius to render it
getHomeR = defaultLayout $ do
   setTitle "Website"
   toWidget
      [lucius|
         @import url(https://fonts.googleapis.com/css?family=Open+Sans);

         h1 {
            font-family: Arial;
            font-size: 30px;
            color: #d3d3d3;
            text-align: center;
            letter-spacing: 0.5em;
         }

         body {
            font-family: Arial;
            font-size: 16px;
            background-image: url(@{StaticR backgrounds_lightgreen2_jpg});
         }

         .sidebar {
            position: absolute;
            width: 25%;
            height: 100%;
            left: 0;
            top: 0;
            background: #228b22;
            font-size: 0.75em;
         }

         .nav {
            position: relative;
            margin: 0 5%;
            text-align: right;
            top: 0;
            font-weight: bold;
         }   

         .nav ul {
            list-style: none;
            
            li {
               position: relative;
               margin: 3.2em 0;

               a {
                  line-height: 5em;
                  text-transform: uppercase;
                  text-decoration: none;
                  letter-spacing: 0.4em;
                  color: #c0c0c0;
                  display: block;
                  transition: all ease-out 300ms;
               }

               &.active a {
                  color: white;
               }

               &:not(.active)::after {
                  opacity: 0.2;
               }

               &:not(.active):hover a {
                  color: rgba(#FFF, 0.75);
               }

               &::after {
                  content: '';
                  position: absolute;
                  width: 100%;
                  height: 0.2em;
                  background: black;
                  left: 0;
                  bottom: 0;
                  background-image: linear-gradient(to right, #228b22, #ffffff);
               }
            }
         }
      |]
   toWidget
      [hamlet|
         <main class="main">
            <aside class="sidebar">
               <nav class="nav">
                  <h1><p>Interests
                  <ul>
                     <li><a href=@{CSR}>Computer Science
                     <li><a href=@{MathR}>Mathematics
                     <li><a href=@{LangR}>Language
                     <li><a href=@{ArtR}>Artwork
      |]

--Subject indices, add CSS later
getCSR :: Handler Html
getCSR = defaultLayout [whamlet|
   <p>Some computer science topics I am interested in
      <ul>
         <li><a href=@{TypesR}>Type Theory
         <li><a href=@{FPR}>Functional Programming
         <li><a href=@{OSDesignR}>Operating System Design
         <li><a href=@{AlgoR}>Algorithms
|]

getMathR :: Handler Html
getMathR = defaultLayout [whamlet|
   <p>Some of the topics in mathematics that interest me
      <ul>
         <li><a href=@{TopologyR}>Topology
         <li><a href=@{LogicR}>Logic
         <li><a href=@{CategoryR}>Category Theory
         <li><a href=@{TopoiR}>Topos Theory
|]

getLangR :: Handler Html
getLangR = defaultLayout [whamlet|
   <p>Some of the languages I have studied
      <ul>
         <li><a href=@{ESR}>Spanish
         <li><a href=@{FRR}>French
         <li><a href=@{EOR}>Esperanto
         <li><a href=@{ETTR}>Etruscan
         <li><a href=@{SEIR}>Seri
|]

getArtR :: Handler Html
getArtR = defaultLayout [whamlet|
   <p>Some of the artwork I have made
      <ul>
         <li><a href=@{OrigamiR}>Origami
         <li><a href=@{CalligraphyR}>Calligraphy
         <li><a href=@{FashionR}>Fashion
|]

--Last webpages in the tree

getTypesR :: Handler Html
getTypesR = defaultLayout [whamlet|Notes on type theory|]

getFPR :: Handler Html
getFPR = defaultLayout [whamlet|Projects involving functional programming|]

getOSDesignR :: Handler Html
getOSDesignR = defaultLayout [whamlet|Some thoughts on operating system design|]

getAlgoR :: Handler Html
getAlgoR = defaultLayout [whamlet|Visualization of some algorithms|]

getTopologyR :: Handler Html
getTopologyR = defaultLayout [whamlet|Some notes on topology|]

getLogicR :: Handler Html
getLogicR = defaultLayout [whamlet|Some notes on logic|]

getCategoryR :: Handler Html
getCategoryR = defaultLayout [whamlet|Some notes on category theory|]

getTopoiR :: Handler Html
getTopoiR = defaultLayout [whamlet|Some notes on topos theory|]

getESR :: Handler Html
getESR = defaultLayout [whamlet|Spanish practice|]

getFRR :: Handler Html
getFRR = defaultLayout [whamlet|French practice|]

getEOR :: Handler Html
getEOR = defaultLayout [whamlet|Esperanto Practice|]

getETTR :: Handler Html
getETTR = defaultLayout [whamlet|Some notes on Etruscan|]

getSEIR :: Handler Html
getSEIR = defaultLayout [whamlet|Some notes on Seri|]

getOrigamiR :: Handler Html
getOrigamiR = defaultLayout [whamlet|A showcase of some of my origami pieces|]

getCalligraphyR :: Handler Html
getCalligraphyR = defaultLayout [whamlet|A showcase of some of my calligraphy cases|]

getFashionR :: Handler Html
getFashionR = defaultLayout [whamlet|A shwocase of some of my fashion ensembles|]

main :: IO ()
main = do
   static@(Static settings) <- static "static"
   warp 3000 $ App static
