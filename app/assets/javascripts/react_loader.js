(function() {
  if(!React)    { console.error('React not defined.'); return; }
  if(!ReactDOM) { console.error('ReactDOM not defined'); return ; }
  var reactRoots = document.querySelectorAll('.react-component');
  var reactRoot, component, props;
  for(var i = 0, len = reactRoots.length; i < len; i++) {
    reactRoot = reactRoots[i];
    component = reactRoot.getAttribute('data-component-name');
    props = JSON.parse(reactRoot.getAttribute('data-props') || '{}');
    if(component && component !== '' && window[component]) {
      ReactDOM.render(React.createElement(window[component], props), reactRoot);
    }
  }
})();