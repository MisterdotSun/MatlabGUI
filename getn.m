function varargout=getn(H,varargin)%һ��varargin��varargout�����صģ�������������Ϊ��������ã�

%ע��ΪԪ������

% �õ�һ������Ķ������

 

if max(size(H))~=1 || ~ishandle(H)

   error('Scalar Object Handle Required.')

end

varargout=get(H,varargin);

