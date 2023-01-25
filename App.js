import React, {useEffect, useState} from 'react';
import {Pressable, StyleSheet, Text, View} from 'react-native';

// Imports the NativeModules bridge which lets us hook into native methods & classes
import {NativeModules, NativeEventEmitter} from 'react-native';

// Hooks into our native event emitter
const CounterEvents = new NativeEventEmitter(NativeModules.Counter);

const App = () => {
  const initialNativeCount = NativeModules.Counter.getConstants().count;

  // Initializes our counter with the value held in the native code's state
  const [reactCount, setReactCount] = useState(initialNativeCount);
  const [reactError, setReactError] = useState(null);

  // An example of a async native method be invoked in JS
  const decreaseAsync = () =>
    NativeModules.Counter.decrement()
      .then((nativeValue) => setReactCount(nativeValue))
      .catch((nativeError) => setReactError(nativeError.message));

  //An example of a synchronous native method being invoked in JS
  const increase = () => {
    setReactError(false);
    NativeModules.Counter.increment((nativeValue) =>
      setReactCount(nativeValue),
    );
  };

  // Sets up event listeners
  useEffect(() => {
    CounterEvents.addListener('onIncrement', (nativeResult) =>
      console.log(`Received increment event ${nativeResult.count}`),
    );

    CounterEvents.addListener('onDecrement', (nativeResult) =>
      console.log(`Received decrement event ${nativeResult.count}`),
    );

    return () => {
      CounterEvents.removeAllListeners();
    };
  }, []);

  return (
    <View style={styles.container}>
      {/* Count Value */}
      <Text style={styles.counter}>{reactCount}</Text>

      {/* Button Container */}
      <View style={styles.buttonContainer}>
        <Pressable
          style={{...styles.button, marginRight: 16}}
          onPress={decreaseAsync}>
          <Text style={styles.text}>Dec</Text>
        </Pressable>

        <Pressable style={styles.button} onPress={increase}>
          <Text style={styles.text}>Inc</Text>
        </Pressable>
      </View>

      {reactError && <Text style={styles.error}>{reactError}</Text>}
    </View>
  );
};

export default App;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  counter: {
    fontSize: 32,
    fontWeight: '800',
    marginBottom: 16,
  },
  buttonContainer: {
    display: 'flex',
    flexDirection: 'row',
  },
  button: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    paddingHorizontal: 32,
    borderRadius: 4,
    elevation: 3,
    backgroundColor: 'blue',
  },
  text: {
    fontSize: 16,
    lineHeight: 21,
    fontWeight: 'bold',
    letterSpacing: 0.25,
    color: 'white',
  },
  error: {
    marginTop: 16,
    color: 'red',
  },
});
