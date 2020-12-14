
/**
* # RNplusAPN
* with ReactNative initial screen
*/

import React, {useState} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Button,
  Pressable
} from 'react-native';

import {NativeModules} from 'react-native';

var Experimental = NativeModules.Experimental;


type Props = {};
const App: (props) => React$Node = (props) => {
    
    const [fileName, setFileName] = useState("bla-bla");
    
return (
        <View style={styles.container}>
        
        <View style= {{ height:'15%', padding:10, alignItems: 'center',}}>
        <View style={styles.button}>
        
        <Button  onPress={() => { Experimental.getMyInfo("secret",(error, files) => {if (error) {
              console.error(error);
            } else {
                    console.log("Button pressed")}}) }} title="Update Key" />
        </View>
        <Pressable onPress={() => {console.log("Pressable")}}>
        <Text style={{ fontSize:16}} >{props.secret}</Text>
        </Pressable>
        
            </View>
        
        <View style= {{ height:'15%', padding:10, alignItems: 'center',}}>
        <View style={styles.button}>
        
        <Button  onPress={() => { Experimental.getMyInfo( "recipients",(error, files) => {if (error) {
                                                         console.error(error);
        } else {
            console.log("Button pressed")}}) }} title="Update Recipients" />
        </View>
        <Pressable onPress={() => {console.log("Pressable")}}>
        <Text style={{textAlign: 'center', fontSize:16}} >{props.recipients}</Text>
        </Pressable>
        
        </View>
        
        <View style= {{ height:'15%', padding:10, alignItems: 'center',}}>
        <View style={styles.button}>
        
        <Button  onPress={() => { Experimental.getMyInfo("notification",(error, files) => {if (error) {
                                                         console.error(error);
                                                         } else {
                                                         console.log("Button pressed")}}) }} title="Update Notification" />
        </View>
        <Pressable onPress={() => {console.log("Pressable")}}>
        <Text style={{textAlign: 'center', fontSize:16}} >{props.notification}</Text>
        </Pressable>
        
        </View>
        
        
        
        
       
        </View>
        );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "space-between",
    backgroundColor: "#fff",
    padding: 20,
    marginTop: 80,
 //  marginBottom: 10,
  marginBottom: 60,
  },
subContainer : {
    justifyContent: "space-between",
    flexDirection: "row",
    height : '15%',
    padding:10,

},
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  button: {
//    backgroundColor: '#C41A16',
    flex:0.6,
 //   height : '60%',
    width:'75%',
    backgroundColor: 'coral',
    
        // justifyContent:'center'
//    flexDirection: "row",
 },
});

export default App;

